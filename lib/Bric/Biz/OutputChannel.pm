package Bric::Biz::OutputChannel;
###############################################################################

=head1 NAME

Bric::Biz::OutputChannel - Bricolage Output Channels.

=head1 VERSION

$Revision: 1.20 $

=cut

our $VERSION = (qw$Revision: 1.20 $ )[-1];

=head1 DATE

$Date: 2003-01-24 06:50:13 $

=head1 SYNOPSIS

  use Bric::Biz::OutputChannel;

  # Constructors.
  $oc = Bric::Biz::OutputChannel->new($init);
  $oc = Bric::Biz::OutputChannel->lookup({ id => $id});
  my $ocs_aref = Bric::Biz::OutputChannel->list($params);
  my @ocs = Bric::Biz::OutputChannel->list($params);

  # Class Methods.
  my $id_aref = Bric::Biz::OutputChannel->list_ids($params);
  my @ids = Bric::Biz::OutputChannel->list_ids($params);

  # Instance Methods.
  $id = $oc->get_id;
  my $name = $oc->get_name;
  $oc = $oc->set_name( $name );
  my $description = $oc->get_description;
  $oc = $oc->set_description($description);
  if ($oc->get_primary) { # do stuff }
  $oc = $oc->set_primary(1); # or pass undef.

  # URI Format instance methods.
  my $uri_format = $oc->get_uri_format;
  $oc->set_uri_format($uri_format);
  my $fixed_uri_format = $oc->get_fixed_uri_format;
  $oc->set_fixed_uri_format($uri_fixed_format);
  my $uri_case = $oc->get_uri_case;
  $oc->set_uri_case($uri_case);
  if ($oc->can_use_slug) { # do stuff }
  $oc->use_slug_on;
  $oc->use_slug_off;

  # Output Channel Includes instance methods.
  my @ocs = $oc->get_includes(@ocs);
  $oc->set_includes(@ocs);
  $oc->add_includes(@ocs);
  $oc->del_includes(@ocs);

  # Active instance methods.
  $oc = $oc->activate;
  $oc = $oc->deactivate;
  $oc = $oc->is_active;

  # Persistence methods.
  $oc = $oc->save;

=head1 DESCRIPTION

Holds information about the output channels that will be associated with
templates and elements.

=cut

#==============================================================================
## Dependencies                        #
#======================================#

#--------------------------------------#
# Standard Dependencies.
use strict;

#--------------------------------------#
# Programatic Dependencies.
use Bric::Config qw(:oc);
use Bric::Util::DBI qw(:all);
use Bric::Util::Grp::OutputChannel;
use Bric::Util::Coll::OCInclude;
use Bric::Util::Fault::Exception::GEN;
use Bric::Util::Fault::Exception::DP;

#==============================================================================
## Inheritance                         #
#======================================#
use base qw(Bric Exporter);
our @EXPORT_OK = qw(MIXEDCASE LOWERCASE UPPERCASE);
our %EXPORT_TAGS = (case_constants => \@EXPORT_OK);

#=============================================================================
## Function Prototypes                 #
#======================================#
my ($get_inc, $parse_uri_format);

#==============================================================================
## Constants                           #
#======================================#

use constant DEBUG => 0;
use constant INSTANCE_GROUP_ID => 23;
use constant GROUP_PACKAGE => 'Bric::Util::Grp::OutputChannel';

# URI Case options.
use constant MIXEDCASE => 1;
use constant LOWERCASE => 2;
use constant UPPERCASE => 3;

# URI Defaults.
use constant DEFAULT_URI_FORMAT => '/categories/year/month/day/slug/';
use constant DEFAULT_FIXED_URI_FORMAT => '/categories/';
use constant DEFAULT_URI_CASE => MIXEDCASE;
use constant DEFAULT_USE_SLUG => 0;

#==============================================================================
## Fields                              #
#======================================#

#--------------------------------------#
# Public Class Fields
# None.

#--------------------------------------#
# Private Class Fields
my $METHS;
my $gen = 'Bric::Util::Fault::Exception::GEN';
my $dp  = 'Bric::Util::Fault::Exception::DP';

my $TABLE = 'output_channel';
my $SEL_TABLES = "$TABLE oc, member m, output_channel_member sm";
my $SEL_WHERES = 'oc.id = sm.object_id AND sm.member__id = m.id';
my $SEL_ORDER = 'oc.name, oc.id';

my @COLS = qw(name description pre_path post_path primary_ce filename
              file_ext uri_format fixed_uri_format uri_case use_slug active);

my @PROPS = qw(name description pre_path post_path primary filename file_ext
               uri_format fixed_uri_format uri_case _use_slug _active);

my $SEL_COLS = 'oc.id, oc.name, oc.description, oc.pre_path, oc.post_path, ' .
  'oc.primary_ce, oc.filename, oc.file_ext, oc.uri_format, ' .
  'oc.fixed_uri_format, oc.uri_case, oc.use_slug, oc.active, m.grp__id';
my @SEL_PROPS = ('id', @PROPS, 'grp_ids');

my @ORD = qw(name description pre_path post_path filename file_ext  uri_format
             fixed_uri_format uri_case use_slug active);
my $GRP_ID_IDX = $#SEL_PROPS;

# These are provided for the OutputChannel::Element subclass to take
# advantage of.
sub SEL_PROPS { @SEL_PROPS }
sub SEL_COLS { $SEL_COLS }
sub SEL_TABLES { $SEL_TABLES }
sub SEL_WHERES { $SEL_WHERES }
sub SEL_ORDER { $SEL_ORDER }
sub GRP_ID_IDX { $GRP_ID_IDX }

#--------------------------------------#
# Instance Fields

# This method of Bricolage will call 'use fields' for you and set some permissions.
BEGIN {
    Bric::register_fields(
      {
       # Public Fields
       # The human readable name field
       'name'                  => Bric::FIELD_RDWR,

       # The human readable description field
       'description'           => Bric::FIELD_RDWR,

       # Path to insert at the beginning of URIs.
       'pre_path'              => Bric::FIELD_RDWR,

       # Path to insert at the end of URIs.
       'post_path'             => Bric::FIELD_RDWR,

       # These will be used to construct file names
       # for content files burned to the Output Channel.
       'filename'              => Bric::FIELD_RDWR,
       'file_ext'              => Bric::FIELD_RDWR,

       # URI formatting settings.
       uri_format              => Bric::FIELD_RDWR,
       fixed_uri_format        => Bric::FIELD_RDWR,
       uri_case                => Bric::FIELD_RDWR,
       _use_slug               => Bric::FIELD_NONE,

       # the flag as to wheather this is a primary
       # output channel
       'primary'               => Bric::FIELD_RDWR,

       # The data base id
       'id'                   => Bric::FIELD_READ,

       # Group IDs.
       'grp_ids'               => Bric::FIELD_READ,

       # Private Fileds
       # The active flag
       '_active'               => Bric::FIELD_NONE,

       # Storage for includes list of OCs.
       '_includes'             => Bric::FIELD_NONE,
       '_include_id'           => Bric::FIELD_NONE,
      });
}

#==============================================================================
## Interface Methods                   #
#======================================#

=head1 PUBLIC INTERFACE

=head2 Public Constructors

=over 4

=item $oc = Bric::Biz::OutputChannel->new( $initial_state )

Instantiates a Bric::Biz::OutputChannel object. An anonymous hash of initial
values may be passed. The supported initial value keys are:

=over 4

=item *

name

=item *

description

=item *

primary

=item *

active (default is active, pass undef to make a new inactive Output Channel)

=back

B<Throws:> NONE.

B<Side Effects:> NONE.

B<Notes:> NONE.

=cut

sub new {
        my ($class, $init) = @_;
        # Set active attribute.
        $init->{_active} = exists $init->{active}
          ? delete $init->{active} : 1;

        # Set file naming attributes.
        $init->{filename} ||= DEFAULT_FILENAME;
        $init->{file_ext} ||= DEFAULT_FILE_EXT;

        # Set URI formatting attributes.
        $init->{uri_format} = $init->{uri_format} ?
          $parse_uri_format->($class->my_meths->{uri_format}{disp},
                              $init->{uri_format})
          : DEFAULT_URI_FORMAT;
        $init->{fixed_uri_format} = $init->{fixed_uri_format} ?
          $parse_uri_format->($class->my_meths->{fixed_uri_format}{disp},
                              $init->{fixed_uri_format})
          : DEFAULT_FIXED_URI_FORMAT;

        # Set URI case and use slug attributes.
        $init->{uri_case} ||= DEFAULT_URI_CASE;
        $init->{_use_slug} = exists $init->{use_slug} && $init->{use_slug}
          ? 1 : 0;

        # Construct this puppy!
        return $class->SUPER::new($init);
}

=item $oc = Bric::Biz::OutputChannel->lookup( { id => $id } )

Looks up and instantiates a new Bric::Biz::OutputChannel object based on the
Bric::Biz::OutputChannel object ID passed. If $id is not found in the database,
lookup() returns undef.

B<Throws:>

=over 4

=item *

Missing required param 'id'.

=item *

Unable to connect to database.

=item *

Unable to prepare SQL statement.

=item *

Unable to select column into arrayref.

=item *

Unable to execute SQL statement.

=item *

Unable to bind to columns to statement handle.

=item *

Unable to fetch row from statement handle.

=back

B<Side Effects:> NONE.

B<Notes:> NONE.

=cut

sub lookup {
    my ($class, $params) = @_;

    die $gen->new( { msg => "Missing required param 'id'" } )
      unless $params->{id};

    my $oc = $class->_do_list($params);

    # We want @$person to have only one value.
    die Bric::Util::Fault::Exception::DP->new({
      msg => 'Too many Bric::Biz::OutputChannel objects found.' }) if @$oc > 1;
    return @$oc ? $oc->[0] : undef;
}

=item ($ocs_aref || @ocs) = Bric::Biz::OutputChannel->list( $criteria )

Returns a list or anonymous array of Bric::Biz::OutputChannel objects based on
the search parameters passed via an anonymous hash. The supported lookup keys
are:

=over 4

=item *

name

=item *

description

=item *

primary

=item *

server_type_id

=item *

include_parent_id

=item *

story_instance_id

=item *

media_instance_id

=item *

uri_format

=item *

uri_case

=item *

use_slug

=item *

active

=back

B<Throws:>

=over 4

=item *

Unable to connect to database.

=item *

Unable to prepare SQL statement.

=item *

Unable to select column into arrayref.

=item *

Unable to execute SQL statement.

=item *

Unable to bind to columns to statement handle.

=item *

Unable to fetch row from statement handle.

=back

B<Side Effects:> NONE.

B<Notes:> NONE.

=cut

sub list {
    my ($class, $params) = @_;
    _do_list($class, $params, undef);
}

=item $ocs_href = Bric::Biz::OutputChannel->href( $criteria )

Returns an anonymous hash of Output Channel objects, where each hash key is an
Output Channel ID, and each value is Output Channel object that corresponds to
that ID. Takes the same arguments as list().

B<Throws:>

=over 4

=item *

Unable to connect to database.

=item *

Unable to prepare SQL statement.

=item *

Unable to select column into arrayref.

=item *

Unable to execute SQL statement.

=item *

Unable to bind to columns to statement handle.

=item *

Unable to fetch row from statement handle.

=back

B<Side Effects:> NONE.

B<Notes:> NONE.

=cut

sub href {
    my ($class, $params) = @_;
    _do_list($class, $params, undef, 1);
}

#--------------------------------------#

=back

=head2 Destructors

=over 4

=item $self->DESTROY

Dummy method to prevent wasting time trying to AUTOLOAD DESTROY.

=cut

sub DESTROY {
    # empty for now
}

#--------------------------------------#

=back

=head2 Public Class Methods

=over 4

=item ($id_aref || @ids) = Bric::Biz::OutputChannel->list_ids( $criteria )

Returns a list or anonymous array of Bric::Biz::OutputChannel object IDs based
on the search criteria passed via an anonymous hash. The supported lookup keys
are the same as for list().

B<Throws:>

=over 4

=item *

Unable to prepare SQL statement.

=item *

Unable to connect to database.

=item *

Unable to select column into arrayref.

=item *

Unable to execute SQL statement.

=item *

Unable to bind to columns to statement handle.

=item *

Unable to fetch row from statement handle.

=back

B<Side Effects:> NONE.

B<Notes:> NONE.

=cut

sub list_ids {
    my ($class, $params) = @_;
    _do_list($class, $params, 1);
}

##############################################################################

=item my $meths = Bric::Biz::OutputChannel->my_meths

=item my (@meths || $meths_aref) = Bric::Biz::OutputChannel->my_meths(TRUE)

Returns an anonymous hash of instrospection data for this object. If called
with a true argument, it will return an ordered list or anonymous array of
intrspection data. The format for each introspection item introspection is as
follows:

Each hash key is the name of a property or attribute of the object. The value
for a hash key is another anonymous hash containing the following keys:

=over 4

=item name

The name of the property or attribute. Is the same as the hash key when an
anonymous hash is returned.

=item disp

The display name of the property or attribute.

=item get_meth

A reference to the method that will retrieve the value of the property or
attribute.

=item get_args

An anonymous array of arguments to pass to a call to get_meth in order to
retrieve the value of the property or attribute.

=item set_meth

A reference to the method that will set the value of the property or
attribute.

=item set_args

An anonymous array of arguments to pass to a call to set_meth in order to set
the value of the property or attribute.

=item type

The type of value the property or attribute contains. There are only three
types:

=over 4

=item short

=item date

=item blob

=back

=item len

If the value is a 'short' value, this hash key contains the length of the
field.

=item search

The property is searchable via the list() and list_ids() methods.

=item req

The property or attribute is required.

=item props

An anonymous hash of properties used to display the property or
attribute. Possible keys include:

=over 4

=item type

The display field type. Possible values are

=over 4

=item text

=item textarea

=item password

=item hidden

=item radio

=item checkbox

=item select

=back

=item length

The Length, in letters, to display a text or password field.

=item maxlength

The maximum length of the property or value - usually defined by the SQL DDL.

=back

=item rows

The number of rows to format in a textarea field.

=item cols

The number of columns to format in a textarea field.

=item vals

An anonymous hash of key/value pairs reprsenting the values and display names
to use in a select list.

=back

B<Throws:> NONE.

B<Side Effects:> NONE.

B<Notes:> NONE.

=cut

sub my_meths {
    my ($pkg, $ord) = @_;

    # Return 'em if we got em.
    return !$ord ? $METHS : wantarray ? @{$METHS}{@ORD} : [@{$METHS}{@ORD}]
      if $METHS;

    # We don't got 'em. So get 'em!
    $METHS = {
              name        => {
                               name     => 'name',
                              get_meth => sub { shift->get_name(@_) },
                              get_args => [],
                              set_meth => sub { shift->set_name(@_) },
                              set_args => [],
                              disp     => 'Name',
                              search   => 1,
                              len      => 64,
                              req      => 1,
                              type     => 'short',
                              props    => {   type       => 'text',
                                              length     => 32,
                                              maxlength => 64
                                          }
                             },
              description => {
                              get_meth => sub { shift->get_description(@_) },
                              get_args => [],
                              set_meth => sub { shift->set_description(@_) },
                              set_args => [],
                              name     => 'description',
                              disp     => 'Description',
                              len      => 256,
                              req      => 0,
                              type     => 'short',
                              props    => { type => 'textarea',
                                            cols => 40,
                                            rows => 4
                                          }
                             },
              pre_path      => {
                             name     => 'pre_path',
                             get_meth => sub { shift->get_pre_path(@_) },
                             get_args => [],
                             set_meth => sub { shift->set_pre_path(@_) },
                             set_args => [],
                             disp     => 'Pre',
                             len      => 64,
                             req      => 0,
                             type     => 'short',
                             props    => {   type       => 'text',
                                             length     => 32,
                                             maxlength => 64
                                         }
                            },
              post_path      => {
                             name     => 'post_path',
                             get_meth => sub { shift->get_post_path(@_) },
                             get_args => [],
                             set_meth => sub { shift->set_post_path(@_) },
                             set_args => [],
                             disp     => 'Post',
                             len      => 64,
                             req      => 0,
                             type     => 'short',
                             props    => {   type       => 'text',
                                             length     => 32,
                                             maxlength => 64
                                         }
                            },
              filename      => {
                             name     => 'filename',
                             get_meth => sub { shift->get_filename(@_) },
                             get_args => [],
                             set_meth => sub { shift->set_filename(@_) },
                             set_args => [],
                             disp     => 'File Name',
                             len      => 32,
                             req      => 0,
                             type     => 'short',
                             props    => { type      => 'text',
                                           length    => 32,
                                           maxlength => 32
                                         }
                            },
              file_ext      => {
                             name     => 'file_ext',
                             get_meth => sub { shift->get_file_ext(@_) },
                             get_args => [],
                             set_meth => sub { shift->set_file_ext(@_) },
                             set_args => [],
                             disp     => 'File Extension',
                             len      => 32,
                             req      => 0,
                             type     => 'short',
                             props    => { type      => 'text',
                                           length    => 32,
                                           maxlength => 32
                                         }
                            },
              uri_format => {
                             name     => 'uri_format',
                             get_meth => sub { shift->get_uri_format(@_) },
                             get_args => [],
                             set_meth => sub { shift->set_uri_format(@_) },
                             set_args => [],
                             disp     => 'URI Format',
                             len      => 64,
                             req      => 0,
                             type     => 'short',
                             props    => { type      => 'text',
                                           length    => 32,
                                           maxlength => 64
                                         }
                            },
              fixed_uri_format => {
                             name     => 'fixed_uri_format',
                             get_meth => sub { shift->get_fixed_uri_format(@_) },
                             get_args => [],
                             set_meth => sub { shift->set_fixed_uri_format(@_) },
                             set_args => [],
                             disp     => 'Fixed URI Format',
                             len      => 64,
                             req      => 0,
                             type     => 'short',
                             props    => { type      => 'text',
                                           length    => 32,
                                           maxlength => 64
                                         }
                            },
               uri_case  => {
                             name     => 'uri_case',
                             get_meth => sub { shift->get_uri_case(@_) },
                             get_args => [],
                             set_meth => sub { shift->set_uri_case(@_) },
                             set_args => [],
                             disp     => 'URI Case',
                             len      => 1,
                             req      => 1,
                             type     => 'short',
                             props    => { type => 'select',
                                           vals => [[ &MIXEDCASE => 'Mixed Case'],
                                                    [ &LOWERCASE => 'Lowercase'],
                                                    [ &UPPERCASE => 'Uppercase'],
                                                   ]
                                         }
                            },
               use_slug  => {
                             name     => 'use_slug',
                             get_meth => sub { shift->can_use_slug(@_) ? 1 : 0 },
                             get_args => [],
                             set_meth => sub { $_[1] ? shift->use_slug_on(@_)
                                                 : shift->use_slug_off(@_) },
                             set_args => [],
                             disp     => 'Use Slug for Filename',
                             len      => 1,
                             req      => 1,
                             type     => 'short',
                             props    => { type => 'checkbox' }
                            },
              active     => {
                             name     => 'active',
                             get_meth => sub { shift->is_active(@_) ? 1 : 0 },
                             get_args => [],
                             set_meth => sub { $_[1] ? shift->activate(@_)
                                                 : shift->deactivate(@_) },
                             set_args => [],
                             disp     => 'Active',
                             len      => 1,
                             req      => 1,
                             type     => 'short',
                             props    => { type => 'checkbox' }
                            },
             };
    return !$ord ? $METHS : wantarray ? @{$METHS}{@ORD} : [@{$METHS}{@ORD}];
}

#--------------------------------------#

=back

=head2 Public Instance Methods

=over 4

=item $id = $oc->get_id

Returns the OutputChannel's unique ID.

B<Throws:> NONE.

B<Side Effects:> NONE.

B<Notes:> NONE.

=item $oc = $oc->set_name( $name )

Sets the name of the Output Channel.

B<Throws:> NONE.

B<Side Effects:> NONE.

B<Notes:> NONE.

=item $name = $oc->get_name()

Returns the name of the Output Channel.

B<Throws:> NONE.

B<Side Effects:> NONE.

B<Notes:> NONE.

=item $oc = $oc->set_description( $description )

Sets the description of the Output Channel.

B<Throws:> NONE.

B<Side Effects:> NONE.

B<Notes:> NONE.

=item $description = $oc->get_description()

Returns the description of the Output Channel.

B<Throws:> NONE.

B<Side Effects:> NONE.

B<Notes:> NONE.

=item $oc = $oc->set_pre_path($pre_path)

Sets the string that will be used at the beginning of the URIs for assets in
this Output Channel.

B<Throws:> NONE.

B<Side Effects:> NONE.

B<Notes:> NONE.

=item $pre_path = $oc->get_pre_path

Gets the string that will be used at the beginning of the URIs for assets in
this Output Channel.

B<Throws:> NONE.

B<Side Effects:> NONE.

B<Notes:> NONE.

=item $oc = $oc->set_post_path($post_path)

Sets the string that will be used at the end of the URIs for assets in this
Output Channel.

B<Throws:> NONE.

B<Side Effects:> NONE.

B<Notes:> NONE.

=item $post_path = $oc->get_post_path

Gets the string that will be used at the end of the URIs for assets in
this Output Channel.

B<Throws:> NONE.

B<Side Effects:> NONE.

B<Notes:> NONE.

=item $oc = $oc->set_filename($filename)

Sets the filename that will be used in the names of files burned into this
Output Channel.

B<Throws:> NONE.

B<Side Effects:> NONE.

B<Notes:> NONE.

=item $filename = $oc->get_filename

=item $filename = $oc->get_filename($asset)

Gets the filename that will be used in the names of files burned into this
Output Channel. Defaults to the value of the DEFAULT_FILENAME configuration
directive if unset. The value of the C<uri_case> property affects the case of
the filename returned. If <$asset> is passed in, then C<get_filename()> will
return the proper filename for that asset based on the value of the
C<use_slug> property and on the class of the asset object.

B<Throws:> NONE.

B<Side Effects:> NONE.

B<Notes:> NONE.

=cut

sub get_filename {
    my ($self, $asset) = @_;
    my ($fn, $us, $case) = $self->_get(qw(filename _use_slug uri_case));

    # Determine what filename to return.
    if ($us && UNIVERSAL::isa($asset, 'Bric::Biz::Asset::Business::Story')) {
        my $slug = $asset->get_slug;
        $fn = $slug if defined $slug && $slug ne '';
    } elsif (UNIVERSAL::isa($asset, 'Bric::Biz::Asset::Business::Media')) {
        $fn = $asset->get_file_name;
    }

    # Return the filename with the proper case.
    return $case eq MIXEDCASE ? $fn :
      $case eq LOWERCASE ? lc $fn : uc $fn;
}

=item $oc = $oc->set_file_ext($file_ext)

Sets the filename extension that will be used in the names of files burned into
this Output Channel.

B<Throws:> NONE.

B<Side Effects:> NONE.

B<Notes:> NONE.

=item $file_ext = $oc->get_file_ext

Gets the filename extension that will be used in the names of files burned
into this Output Channel. Defaults to the value of the DEFAULT_FILE_EXT
configuration directive if unset. The case of the file extension returned is
affected by the value of the C<uri_case> property.

B<Throws:> NONE.

B<Side Effects:> NONE.

B<Notes:> NONE.

=cut

sub get_file_ext {
    my ($ext, $case) = $_[0]->_get(qw(file_ext uri_case));
    return $case eq MIXEDCASE ? $ext :
      $case eq LOWERCASE ? lc $ext : uc $ext;
}

=item $oc = $oc->set_primary( undef || 1)

Set the flag that indicates whether or not this is the primary Output Channel.

B<Throws:> NONE.

B<Side Effects:> NONE.

B<Notes:> NONE.

=item (undef || 1 ) = $oc->get_primary

Returns true if this is the primary Output Channel and false (undef) if it is
not.

B<Throws:> NONE.

B<Side Effects:> NONE.

B<Notes:> Only one Output channel can be the primary output channel.

=item $oc = $oc->set_uri_format($uri_format)

Sets the URI format for documents output in this Output Channel.

B<Throws:>

=over 4

=item *

No URI Format value specified.

=item *

Invalid URI Format tokens.

=back

B<Side Effects:> NONE.

B<Notes:> NONE.

=cut

sub set_uri_format {
    $_[0]->_set(['uri_format'],
                [$parse_uri_format->($_[0]->my_meths->{uri_format}{disp},
                                     $_[1])])
}

=item my $format = $oc->get_uri_format

Returns the URI format for documents output in this Output Channel.

B<Throws:> NONE.

B<Side Effects:> NONE.

B<Notes:> Only one Output channel can be the uri_format output channel.

=item $oc = $oc->set_fixed_uri_format($uri_format)

Sets the fixed URI format for documents output in this Output Channel.

B<Throws:>

=over 4

=item *

No Fixed URI Format value specified.

=item *

Invalid Fixed URI Format tokens.

=back

B<Side Effects:> NONE.

B<Notes:> NONE.

=cut

sub set_fixed_uri_format {
    $_[0]->_set(['fixed_uri_format'],
                [$parse_uri_format->($_[0]->my_meths->{fixed_uri_format}{disp},
                                     $_[1])])
}

=item (undef || 1 ) = $oc->can_use_slug

Returns true if this is Output Channel can use the C<slug> property of a story
as the filename for files output for the story.

B<Throws:> NONE.

B<Side Effects:> NONE.

B<Notes:> NONE.

=cut

sub can_use_slug { $_[0]->_get('_use_slug') ? $_[0] : undef }

##############################################################################

=item $oc = $oc->use_slug_on

Sets the C<use_slug> property to a true value.

B<Throws:> NONE.

B<Side Effects:> NONE.

B<Notes:> NONE.

=cut

sub use_slug_on { $_[0]->_set(['_use_slug'], [1]) }

##############################################################################

=item $oc = $oc->use_slug_off

Sets the C<use_slug> property to a false value.

B<Throws:> NONE.

B<Side Effects:> NONE.

B<Notes:> NONE.

=cut

sub use_slug_off { $_[0]->_set(['_use_slug'], [0]) }

##############################################################################

=item my @inc = $oc->get_includes

=item my $inc_aref = $oc->get_includes

Returns a list or anonymous array of Bric::Biz::OutputChannel objects that
constitute the include list for this OutputChannel. Templates not found in this
OutputChannel will be sought in this list of OutputChannels, looking at each one
in the order in which it was returned from this method.

B<Throws:>

=over 4

=item *

Bric::_get() - Problems retrieving fields.

=item *

Incorrect number of args to Bric::_set().

=item *

Bric::set() - Problems setting fields.

=item *

Unable to connect to database.

=item *

Unable to prepare SQL statement.

=item *

Unable to select column into arrayref.

=item *

Unable to execute SQL statement.

=item *

Unable to bind to columns to statement handle.

=item *

Unable to fetch row from statement handle.

=back

B<Side Effects:> NONE.

B<Notes:> NONE.

=cut

sub get_includes {
    my $inc = $get_inc->(shift);
    return $inc->get_objs(@_);
}

##############################################################################

=item $job = $job->add_includes(@ocs)

Adds Output Channels to this to the include list for this Output Channel. Output
Channels added to the include list via this method will be appended to the end
of the include list. The order can only be changed by resetting the entire
include list via the set_includes() method. Call save() to save the
relationship.

B<Throws:>

=over 4

=item *

Bric::_get() - Problems retrieving fields.

=item *

Incorrect number of args to Bric::_set().

=item *

Bric::set() - Problems setting fields.

=back

B<Side Effects:> NONE.

B<Notes:> Uses Bric::Util::Coll::Server internally.

=cut

sub add_includes {
    my $self = shift;
    my $inc = &$get_inc($self);
    $inc->add_new_objs(@_);
    $self->_set__dirty(1);
}

################################################################################

=item $self = $job->del_includes(@ocs)

Deletes Output Channels from the include list. Call save() to save the
deletes to the database.

B<Throws:>

=over 4

=item *

Bric::_get() - Problems retrieving fields.

=item *

Incorrect number of args to Bric::_set().

=item *

Bric::set() - Problems setting fields.

=item *

Unable to connect to database.

=item *

Unable to prepare SQL statement.

=item *

Unable to select column into arrayref.

=item *

Unable to execute SQL statement.

=item *

Unable to bind to columns to statement handle.

=item *

Unable to fetch row from statement handle.

=back

B<Side Effects:> NONE.

B<Notes:> NONE.

=cut

##############################################################################

sub del_includes {
    my $self = shift;
    my $inc = &$get_inc($self);
    $inc->del_objs(@_);
    $self->_set__dirty(1);
}

=item $self = $self->set_includes(@ocs);

Sets the list of Output channels to set as the include list for this Output
Channel. Any existing Output Channels in the includes list will be removed from
the list. To add Output Channels to the include list without deleting the
existing ones, use add_includes().

B<Throws:>

=over 4

=item *

Output Channel cannot include itself.

=back

B<Side Effects:> NONE.

B<Notes:> NONE.

=cut

sub set_includes {
    my $self = shift;
    my $inc = &$get_inc($self);
    $inc->del_objs($inc->get_objs);
    $inc->add_new_objs(@_);
    $self->_set__dirty(1);
}

##############################################################################

=item $self = $oc->activate

Activates the Bric::Biz::OutputChannel object. Call $oc->save to make the change
persistent. Bric::Biz::OutputChannel objects instantiated by new() are active by
default.

B<Throws:> NONE.

B<Side Effects:> NONE.

B<Notes:> NONE.

=cut

sub activate { $_[0]->_set({_active => 1 }) }

##############################################################################

=item $self = $oc->deactivate

Deactivates (deletes) the Bric::Biz::OutputChannel object. Call $oc->save to
make the change persistent.

B<Throws:> NONE.

B<Side Effects:> NONE.

B<Notes:> NONE.

=cut

sub deactivate { $_[0]->_set({_active => 0 }) }

##############################################################################

=item $self = $oc->is_active

Returns $self (true) if the Bric::Biz::OutputChannel object is active, and undef
(false) if it is not.

B<Throws:> NONE.

B<Side Effects:> NONE.

B<Notes:> NONE.

=cut

sub is_active { $_[0]->_get('_active') ? $_[0] : undef }

##############################################################################

=item $self = $oc->save

Saves any changes to the Bric::Biz::OutputChannel object. Returns $self on
success and undef on failure.

B<Throws:>

=over 4

=item *

Bric::_get() - Problems retrieving fields.

=item *

Unable to connect to database.

=item *

Unable to prepare SQL statement.

=item *

Unable to execute SQL statement.

=item *

Unable to select row.

=item *

Incorrect number of args to _set.

=item *

Bric::_set() - Problems setting fields.

=back

B<Side Effects:> NONE.

B<Notes:> NONE.

=cut

sub save {
    my ($self) = @_;
    return $self unless $self->_get__dirty;
    my ($id, $inc) = $self->_get('id', '_includes');
    defined $id ? $self->_do_update($id) : $self->_do_insert;
    $inc->save($id) if $inc;
    $self->SUPER::save();
}

##############################################################################

=back

=head1 PRIVATE

=head2 Private Class Methods

=over 4

=item _do_list

Called by list and list ids this does the brunt of their work.

B<Throws:>

=over 4

=item *

Unable to connect to database.

=item *

Unable to prepare SQL statement.

=item *

Unable to select column into arrayref.

=item *

Unable to execute SQL statement.

=item *

Unable to bind to columns to statement handle.

=item *

Unable to fetch row from statement handle.

=back

B<Side Effects:> NONE.

B<Notes:> NONE.

my %bool_map = ( active  => 'oc.active = ?',
                 use_slug => 'oc.use_slug = ?',
);

my %txt_map = ( name            => 'LOWER(oc.name) LIKE ?',
                description      => 'LOWER(oc.description) LIKE ?',
                pre_path         => 'LOWER(oc.pre_path) LIKE ?',
                post_path        => 'LOWER(oc.post_path) LIKE ?',
                uri_format       => 'LOWER(oc.uri_format) LIKE ?',
                fixed_uri_format => 'LOWER(oc.fixed_uri_format) LIKE ?',
);
my %num_map = ( primary          => 'oc.primary_ce = ?',
                id                => 'oc.id = ?',
                uri_case          => 'oc.uri_case = ?',
                server_type_id    => 'oc.id IN (SELECT output_channel__id '
                                     . 'FROM server_type__output_channel '
                                     . 'WHERE server_type__id = ?)',
                media_instance_id => 'oc.id IN (SELECT output_channel__id '
                                     . 'FROM media__output_channel '
                                     . 'WHERE media_instance__id = ?)',
                story_instance_id => 'oc.id IN (SELECT output_channel__id '
                                     . 'FROM story__output_channel '
                                     . 'WHERE story_instance__id = ?)',
                include_parent_id => 'inc.output_channel__id = ?'
);

=cut

sub _do_list {
    my ($pkg, $params, $ids, $href) = @_;
    my $tables = $SEL_TABLES;
    my $wheres = $SEL_WHERES;
    my @params;
    while (my ($k, $v) = each %$params) {
        if ($k eq 'id' or $k eq 'uri_case') {
            # Simple numeric comparison.
            $wheres .= " AND oc.$k = ?";
            push @params, $v;
        } elsif ($k eq 'primary') {
            # Simple numeric comparison.
            $wheres .= " AND oc.primary_ce = ?";
            push @params, $v;
        } elsif ($k eq 'active' or $k eq 'use_slug') {
            # Simple boolean comparison.
            $wheres .= " AND oc.$k = ?";
            push @params, $v ? 1 : 0;
        } elsif ($k eq 'grp_id') {
            # Add in the group tables a second time and join to them.
            $tables .= ", member m2, output_channel_member c2";
            $wheres .= " AND oc.id = c2.object_id AND c2.member__id = m2.id" .
              " AND m2.grp__id = ?";
            push @params, $v;
        } elsif ($k eq 'include_parent_id') {
            # Include the parent ID.
            $tables .= ', output_channel_include inc';
            $wheres .= ' AND oc.id = inc.include_oc_id ' .
              'AND inc.output_channel__id = ?';
            push @params, $v;
        } elsif ($k eq 'server_type_id') {
            # Join in the server_type__output_channel table.
            $tables .= ', server_type__output_channel stoc';
            $wheres .= ' AND oc.id = stoc.output_channel__id ' .
              'AND stoc.server_type__id = ?';
            push @params, $v;
        } elsif ($k eq 'story_instance_id') {
            # Join in the story__output_channel table.
            $tables .= ', story__output_channel soc';
            $wheres .= ' AND oc.id = soc.output_channel__id ' .
              'AND soc.story_instance__id = ?';
            push @params, $v;
        } elsif ($k eq 'media_instance_id') {
            # Join in the media__output_channel table.
            $tables .= ', media__output_channel moc';
            $wheres .= ' AND oc.id = moc.output_channel__id ' .
              'AND moc.media_instance__id = ?';
            push @params, $v;
        } elsif ($k eq 'include_parent_id') {
            $wheres .= ' AND inc.output_channel__id = ?';
            push @params, $v;
        } else {
            # Simple string comparison!
            $wheres .= " AND LOWER(oc.$k) LIKE ?";
            push @params, lc $v;
        }
    }

    my ($order, $props, $qry_cols) = ($SEL_ORDER, \@SEL_PROPS, \$SEL_COLS);
    if ($ids) {
        $qry_cols = \'oc.id';
        $order = 'oc.id';
    } elsif ($params->{include_parent_id}) {
        $qry_cols = \"$SEL_COLS, inc.id";
        $props = [@SEL_PROPS, '_include_id'];
    } # Else nothing!

    # Assemble and prepare the query.
    my $sel = prepare_c(qq{
        SELECT $$qry_cols
        FROM   $tables
        WHERE  $wheres
        ORDER BY $order
    }, undef, DEBUG);

    # Just return the IDs, if they're what's wanted.
    return wantarray ? @{ col_aref($sel, @params) } : col_aref($sel, @params)
      if $ids;

    # Grab all the records.
    execute($sel, @params);
    my (@d, @ocs, %ocs, $grp_ids);
    bind_columns($sel, \@d[0..$#$props]);
    my $last = -1;
    $pkg = ref $pkg || $pkg;
    while (fetch($sel)) {
        if ($d[0] != $last) {
            $last = $d[0];
            # Create a new server type object.
            my $self = bless {}, $pkg;
            $self->SUPER::new;
            # Get a reference to the array of group IDs.
            $grp_ids = $d[$GRP_ID_IDX] = [$d[$GRP_ID_IDX]];
            $self->_set($props, \@d);
            $self->_set__dirty; # Disables dirty flag.
            $href ? $ocs{$d[0]} = $self : push @ocs, $self
        } else {
            push @$grp_ids, $d[$GRP_ID_IDX];
        }
    }
    # Return the objects.
    return $href ? \%ocs : wantarray ? @ocs : \@ocs;
}

##############################################################################

=back

=head2 Private Instance Methods

=over 4

=item _do_update()

Will perform the update to the database after being called from save.

B<Throws:>

=over 4

=item *

Bric::_get() - Problems retrieving fields.

=item *

Unable to connect to database.

=item *

Unable to prepare SQL statement.

=item *

Unable to execute SQL statement.

=item *

Unable to select row.

=item *

Incorrect number of args to _set.

=item *

Bric::_set() - Problems setting fields.

=back

B<Side Effects:> NONE.

B<Notes:> NONE.

=cut

sub _do_update {
    my ($self, $id) = @_;
    local $" = ' = ?, '; # Simple way to create placeholders with an array.
    my $upd = prepare_c(qq{
        UPDATE $TABLE
        SET    @COLS = ?
        WHERE  id = ?
    });
    execute($upd, $self->_get(@PROPS), $id);
    return $self;
}

##############################################################################

=item _do_insert

Will do the insert to the database after being called by save

B<Throws:>

=over 4

=item *

Bric::_get() - Problems retrieving fields.

=item *

Unable to connect to database.

=item *

Unable to prepare SQL statement.

=item *

Unable to execute SQL statement.

=item *

Unable to select row.

=item *

Incorrect number of args to _set.

=item *

Bric::_set() - Problems setting fields.

=back

B<Side Effects:> NONE.

B<Notes:> NONE.

=cut

sub _do_insert {
    my ($self) = @_;

    local $" = ', ';
    my $fields = join ', ', next_key('output_channel'), ('?') x @COLS;
    my $ins = prepare_c(qq{
        INSERT INTO output_channel (id, @COLS)
        VALUES ($fields)
    }, undef, DEBUG);
    execute($ins, $self->_get( @PROPS ) );
    $self->_set( { 'id' => last_key($TABLE) } );
    $self->register_instance(INSTANCE_GROUP_ID, GROUP_PACKAGE);
    return $self;
}

##############################################################################

=back

=head2 Private Functions

=over 4

=item my $inc_coll = &$get_inc($self)

Returns the collection of Output Channels that costitute the includes. The
collection a Bric::Util::Coll::OCInclude object. See Bric::Util::Coll for
interface details.

B<Throws:>

=over 4

=item *

Bric::_get() - Problems retrieving fields.

=item *

Unable to prepare SQL statement.

=item *

Unable to connect to database.

=item *

Unable to select column into arrayref.

=item *

Unable to execute SQL statement.

=item *

Unable to bind to columns to statement handle.

=item *

Unable to fetch row from statement handle.

=item *

Incorrect number of args to Bric::_set().

=item *

Bric::set() - Problems setting fields.

=back

B<Side Effects:> NONE.

B<Notes:> NONE.

=cut

$get_inc = sub {
    my $self = shift;
    my ($id, $inc) = $self->_get('id', '_includes');

    unless ($inc) {
        $inc = Bric::Util::Coll::OCInclude->new
          (defined $id ? { include_parent_id => $id } : undef);
        my $dirty = $self->_get__dirty;
        $self->_set(['_includes'], [$inc]);
        $self->_set__dirty($dirty);
    }
    return $inc;
};

##############################################################################

=item my $uri_format = $parse_uri_format->($name, $format)

Parses a URI format as passed to C<set_uri_format()> or
C<set_fixed_uri_format()> and returns it if it parses properly. If it doesn't,
it throws an exception. The C<$name> attribute is used in the exceptions.

B<Throws:>

=over 4

=item *

No URI Format value specified.

=item *

Invalid URI Format tokens.

=back

B<Side Effects:> NONE.

B<Notes:> NONE.

=cut

$parse_uri_format = sub {
    my ($name, $format) = @_;
    my %toks = map { $_ => 1 } qw(categories day month year slug);

    # Throw an exception for an empty or bogus format.
    die Bric::Util::Fault::Exception::DP->new
      ({ msg => "No $name value specified" })
      if not $format or $format =~ /^\s*$/;

    # Parse the format for invalid tokens.
    $format =~ s#/?(.+)/?#$1#;
    my (@tokens, @bad);
    foreach my $token (split /\//, $format) {
        $toks{$token} ?
          push @tokens, $token :
          push @bad, $token;
    }

    # Throw an exception for a format with invalid tokens.
    if (my $c = @bad) {
        my $pl = $c > 1 ? 's' : '';
        my $bad = join ', ', @bad;
        die Bric::Util::Fault::Exception::DP->new
          ({ msg => "Invalid $name token$pl: $bad" });
    }

    # Return the format.
    return '/' . join('/', @tokens) . '/';
};


1;
__END__

=back

=head1 NOTES

NONE.

=head1 AUTHORS

Michael Soderstrom <miraso@pacbell.net>

David Wheeler <david@wheeler.net>

=head1 SEE ALSO

L<perl>, L<Bric>, L<Bric::Biz::Asset::Business>, L<Bric::Biz::AssetType>,
L<Bric::Biz::Asset::Formatting>.

=cut
