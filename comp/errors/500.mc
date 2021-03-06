% # Check to see if this is a preview screen.
% my $prev = $r->pnotes('burner.preview');
% unless ($is_partial) {
<& /widgets/wrappers/header.mc,
        title      => 'Error',
        useSideNav => !$prev,
        no_toolbar => !$prev,
        context    => 'An error occurred.',
        debug      => QA_MODE || TEMPLATE_QA_MODE,
        popup      => !!get_state_data('_profile_return'), # Should be a popup when creating related media.
 &>

<p><% $lang->maketext('An error occurred while processing your request:')%></p>

% }
<div id="servererror">
% if (isa_exception($fault)) {
<p class="errorMsg"><% escape_html($fault->error) %></p>
% }

% if (isa_bric_exception($fault) and my $pay = $fault->payload) {
<pre><% escape_html($pay) %></pre>
% }

<div class="debug">
<h3 class="show"><a href="#" onclick="Element.addClassName(this.parentNode.parentNode, 'expanded'); return false">View Error Details</a></h3>
<h3 class="hide">Error Details <a href="#" onclick="Element.removeClassName(this.parentNode.parentNode, 'expanded'); return false">(hide)</a></h3>

<div class="content">
<dl>
% if ($is_burner_error) {
  <dt>Output Channel</dt> <dd><% $fault->oc || '&nbsp;' %></dd>
  <dt>Category</dt>       <dd><% $fault->cat || '&nbsp;' %></dd>
  <dt>Element</dt>        <dd><% $fault->elem || '&nbsp;' %></dd>
% }
% if (isa_exception($fault)) {
  <dt>Fault Class</dt>    <dd><% ref $fault %></dd>
  <dt>Description</dt>    <dd><% $fault->description || '&nbsp;' %></dd>
  <dt>Timestamp</dt>      <dd><% strfdate($fault->time) %></dd>
  <dt>Package</dt>        <dd><% $fault->package || '&nbsp;' %></dd>
  <dt>Filename</dt>       <dd><% $fault->file || '&nbsp;' %></dd>
  <dt>Line</dt>           <dd><% $fault->line || '&nbsp;' %></dd>
% }
</dl>

<p><b>Stack:</b></p>
<pre><% HTML::Mason::Exceptions::isa_mason_exception($fault) ? $fault->as_text : $fault->trace->as_string %></pre>

% if (QA_MODE) {
<p><b>Request args:</b></p>
<dl>
% while (my ($arg, $value) = each %req_args) {
  <dt><% $arg %></dt> <dd><% escape_html($value) %></dd>
% }
</dl>
<& '/widgets/debug/debug.mc' &>
% }
</div>
</div>

% if ($prev && $is_burner_error) {
%     my $element = $fault->element;
%     my @elements = ($element);
%     while (my $parent = $elements[0]->get_parent) {
%         unshift @elements, $parent;
%     }
<p>Location of the error:<br/>
<% shift(@elements)->get_name %> -> <% join(' -> ', map { $_->get_name . '[' . ($_->get_place + 1) . ']' } @elements) %></p>
% }

% unless (isa_bric_exception($fault, 'Exception::Burner::User')) {
<p>Please report this error to your administrator.  It may be helpful to include the error details in your report.</p>
% }

</div>
% $m->comp('/widgets/wrappers/footer.mc') unless $is_partial;
% $r->status(HTTP_INTERNAL_SERVER_ERROR);
% $m->abort;
<%init>;
# Clear out messages - they're likely irrelevant now.
clear_msg();

# exception object ($fault) and $more_args are now always
# in pnotes, not passed in %args
my $fault = $r->pnotes('BRIC_EXCEPTION');
warn "'$fault' not an exception object" unless isa_exception($fault);

my $more_err = $r->pnotes('BRIC_MORE_ERR');

my $pay = isa_bric_exception($fault) ? ($fault->payload || '') : '';

my $is_burner_error = isa_bric_exception($fault, 'Exception::Burner');
my %req_args = HTML::Mason::Request->instance->request_args;
my $is_partial = $r->headers_in->{'X-Requested-With'} eq 'XMLHttpRequest';
</%init>
