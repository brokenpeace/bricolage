package Bric::Util::Language::zh_cn;

=head1 NAME

Bric::Util::Language::zh_cn - Bricolage 简体中文翻译

=head1 VERSION

$Revision: 1.9 $

=cut

our $VERSION = (qw$Revision: 1.9 $ )[-1];

=head1 DATE

$Date$

=head1 SYNOPSIS

In F<bricolage.conf>:

  LANGUAGE = zh_cn

=head1 DESCRIPTION

Bricolage 简体中文翻译.

=cut

use strict;
use utf8;
use base qw(Bric::Util::Language);

use constant key => 'zh_cn';

our %Lexicon =
   (
    ' contains illegal characters!' => ' 内有非法字符 !',
    '"[_1]" Elements saved.' => '[_1] 元素已被储存。',
    '404 NOT FOUND' => '404 网页找不到',
    'A template already exists for the selected output channel, category, element and burner you selected.  You must delete the existing template before you can add a new one.' => '所选的输出频道、分类、元素、与burner已有对应之起用的模板，在增加新的模板之前，你必须先删除目前存在的模板。',
    'ADMIN' => '管理',
    'ADVANCED SEARCH' => '高级查找',
    'Action profile "[_1]" deleted.' => '行动设定「[_1]」已删除',
    'Action profile "[_1]" saved.' => '行动设定「[_1]」已储存',
    'Actions' => '行动',
    'Active Media' => '编修中的媒体',
    'Active Stories' => '编修中的稿件',
    'Active Templates' => '编修中的模板',
    'Active' => '起用',
    'Add New Field' => '增加一个新栏位',
    'Add a New Alert Type' => '增加新的警告型别',
    'Add a New Category' => '增加一个新的分类',
    'Add a New Contributor Type' => '增加新的供稿者型别',
    'Add a New Desk' => '增加一个新桌面',
    'Add a New Destination' => '增加新的目标',
    'Add a New Element Type' => '增加一个新的元素型别',
    'Add a New Element' => '增加新的元素',
    'Add a New Group' => '增加新的群组',
    'Add a New Media Type' => '增加一个新的媒体型别',
    'Add a New Output Channel' => '增加一个新的输出频道',
    'Add a New Source' => '增加新的来源',
    'Add a New User' => '增加新的使用者',
    'Add a New Workflow' => '增加新的流程',
    'Add to Element' => '加入到元素',
    'Add to Include' => '将这些包含在内',
    'Add' => '增加',
    'Admin' => '管理',
    'Advanced Search' => '高级查找',
    'Alert Type Manager' => '警告类型管理',
    'Alert Type profile "[_1]" deleted.' => '警告类型设定「[_1]」已删除',
    'Alert Type profile "[_1]" saved.' => '警告类型设定「[_1]」已储存',
    'Alert Types' => '警告类型',
    'All Contributors' => '所有的供稿者',
    'All Elements' => '所有的元素',
    'All Groups' => '所有的群组',
    'Allow multiple' => '允许多选',
    'An [_1] attribute already exists. Please try another name.' => '[_1] 属性已存在，请用别的名称。',
    'An error occurred while processing your request:' => '在处理您的要求时，发生了一个错误；',
    'An error occurred.' => '错误突然出现。',
    'Apr' => '四月',
    'At least one extension is required.' => '至少需要一个延伸.',
    'Attributes' => '属性',
    'Aug' => '八月',
    'Available Groups' => '可用的群组',
    'Available Output Channels' => '可用的输出频道',
    'Bad element name "[_1]". Did you mean "[_2]"?' => '元素名称错误：「[_1]」。也许您是指「[_2]」？',
    'By Last' => '依照最后',
    'By Source name' => '按照来源名称',
    'CONTACTS' => '联络人',
    'Cannot auto-publish related media "[_1]" because it is checked out.' => '无法自动出版相关的媒体 [_1] ，因为它尚未送回',
    'Cannot auto-publish related story "[_1]" because it is checked out.' => '因其仍被他人取出，所以无法自动出版以下此篇相关的故事：「[_1]」',
    'Cannot both delete and make primary a single output channel.' => '你不能够对输出频道同时进行删除与「设为主要」的动作',
    'Cannot cancel "[_1]" because it is currently executing.' => '不能取消 [_1] ，因为它目前正在执行中。',
    'Cannot create an alias to a media in the same site.' => '在同站之中无法建立媒体的别名',
    'Cannot create an alias to a story in the same site.' => '在同站之中无法建立故事的别名',
    'Cannot move [_1] asset "[_2]" while it is checked out' => '不能将 [_1] 资产移动到 \'[_2]\' ，因为目前已被取出',
    'Cannot preview asset "[_1]" because there are no Preview Destinations associated with its output channels.' => '无法预览此资产：「[_1]」。其输出频道没有对应到任何预览用的发布目标。',
    'Cannot publish asset "[_1]" to "[_2]" because there are no Destinations associated with this output channel.' => '无法将资产「[_1]]」发布到「[_2]]」，因为此输出频道没有设定散布目标。',
    'Cannot publish checked-out media "[_1]"' => '尚未送回的媒体 [_1] 不能被出版',
    'Cannot publish checked-out story "[_1]"' => '未送回的稿子 [_1] 不能出版',
    'Cannot publish media "[_1]" because it is checked out.' => '因其仍被他人取出，所以无法出版以下媒体：「[_1]」',
    'Cannot publish story "[_1]" because it is checked out.' => '因其仍被他人取出，所以无法出版以下故事：「[_1]」',
    'Caption' => '标题',
    'Categories' => '分类',
    'Category "[_1]" added.' => '分类 [_1] 已加入.',
    'Category "[_1]" cannot be deleted.' => '分类 [_1] 不能被删除。',
    'Category "[_1]" disassociated.' => '以断绝「[_1]」这个分类的关系',
    'Category Assets' => '分类资产',
    'Category Manager' => '分类管理',
    'Category Permissions' => '分类权限',
    'Category URI' => '分类URI',
    'Category profile "[_1]" and all its categories deleted.' => '分类设定 [1] 与其所有分类皆已删除。',
    'Category profile "[_1]" deleted.' => '分类设定 [_1] 已删除。',
    'Category profile "[_1]" saved.' => '分类设定 [_1] 已储存。',
    'Category tree' => '分类树',
    'Category' => '分类',
    'Changes not saved: permission denied.' => '无法储存：权限遭拒',
    'Characters' => '字元',
    'Check In Assets' => '送回资产',
    'Check In To' =>'送回至',
    'Check In to Edit' => '送回给编辑',
    'Check In to Publish' => '送回至 Publish',
    'Check In to [_1]' => '送回到 [_1]',
    'Check In to' => '送回到',
    'Check In' => '送回',
    'Check Out' => '取出',
    'Choose Contributors' => '选取供稿者',
    'Choose Related Media' => '选择相关的媒体',
    'Choose Subelements' => '选择子元素',
    'Choose a Related Story' => '选择相关的稿件',
    'Clone'  => '复制',
    'Columns' => '栏',
    'Contacts' => '联络人',
    'Content Type' => '内容类型',
    'Content' => '内容',
    'Contributor "[_1]" disassociated.' => '已断绝供稿者 [_1] 的关系。',
    'Contributor Roles' => '供稿者角色',
    'Contributor Type Manager' => '供稿者型别管理',
    'Contributor Types' => '供稿者型别',
    'Contributor profile "[_1]" deleted.' => '供稿者设定 [_1] 已删除。',
    'Contributor profile "[_1]" saved.' => '供稿者设定 [_1] 已储存。',
    'Contributors disassociated.' => '已断绝供稿者的关系',
    'Contributors' => '供稿者',
    'Cover Date incomplete.' => '见报日期不完整。',
    'Cover Date' => '见报日期',
    'Create a New Category' => '建立新的分类',
    'Create a New Media' => '建立一个新的媒体',
    'Create a New Story' => '增加一份新的稿件',
    'Create a New Template' => '建立新模板',
    'Current Groups' => '目前的群组',
    'Current Note' => '目前的注意事项',
    'Current Output Channels' => '目前采用的输出频道',
    'Current Version' => '目前版本',
    'Currently Related Story' => '目前相关的稿件',
    'Custom Fields' => '自订栏位',
    'DISTRIBUTION' => '散布',
    'Data Elements' => '资料元素',
    'Day' => '日',
    'Dec' => '十二月',
    'Default Value' => '预设值',
    'Delete this Category and All its Subcategories' => '删除这个分类以及其所有子分类',
    'Delete this Desk from all Workflows' => '自所有流程中删除此桌面',
    'Delete this Element' => '删除这个元素',
    'Delete this Profile' => '删除这个设定',
    'Delete' => '删除',
    'Deploy' => '布署',
    'Deployed Date' => '布署的日期',
    'Description' => '描述',
    'Desk Permissions' => '桌面权限',
    'Desk profile "[_1]" deleted from all workflows.' => '桌面设定 [_1] 已从所有的流程中删除。',
    'Desk'   => '桌面',
    'Desks'   => '桌面',
    'Destination Manager' => '发布目标管理',
    'Destination not specified' => '尚未指定发布目标',
    'Destination profile "[_1]" deleted.' => '发布目标 [_1] 已删除。',
    'Destination profile "[_1]" saved.' => '发布目标 [_1] 已储存。',
    'Destinations' => '发布目标',
    'Development' => '发展',
    'Directory name "[_1]" contains invalid characters. Please try a different directory name.' => '目录名称[_1]还有非法的字符，请调整目录名称。',
    'Distributing files.' => '档案散布中',
    'Download' => '下载',
    'EXISTING CATEGORIES' => '已有的分类',
    'EXISTING DESTINATIONS' => '已有的目标',
    'EXISTING ELEMENT TYPES' => '已有的元素类型',
    'EXISTING ELEMENTS' => '已有的元素',
    'EXISTING MEDIA TYPES' => '已有的媒体类型',
    'EXISTING OUTPUT CHANNELS' => '<b>已有的输出频道</b>',
    'EXISTING SOURCES' => '已有的来源',
    'EXISTING USERS' => '已有的使用者',
    'Edit' => '编辑',
    'Element "[_1]" deleted.' => '元素 [_1] 已删除。',
    'Element "[_1]" saved.' => '元素[_1]已储存',
    'Element Manager' => '元素管理',
    'Element Type Manager' => '元素类别管理',
    'Element Type profile "[_1]" deleted.' => '元素类型设定 [_1] 已删除。',
    'Element Type profile "[_1]" saved.' => '元素类型设定 [_1] 已储存。',
    'Element Types' => '元素类型',
    'Element must be associated with at least one site and one output channel.' => '任何元素都必须关联到至少一个站，与输出频道。',
    'Element' => '元素',
    'Elements' => '元素',
    'Error' => '错误',
    'Event Type' => '事件类型',
    'Events' => '事件',
    'Existing Notes' => '目前的注意事项',
    'Existing Subelements' => '已有的子元素',
    'Existing roles' => '已有的角色',
    'Expire Date incomplete.' => '到期日不完整。',
    'Expire Date' => '到期日',
    'Expire' => '到期',
    'Extension "[_1]" ignored.' => '副档名 [_1] 已被忽略',
    'Extension "[_1]" is already used by media type "[_2]".' => '副档名 [_1] 已被其他媒体类型所用',
    'Extension' => '副档名',
    'Extensions' => '副档名',
    'Feb' => '二月',
    'Field "[_1]" appears more than once but it is not a repeatable element.  Please remove all but one.' => '「[_1]」栏位出现了一次以上，不过它并非可重复的元素，因此请移除多余的部份。',
    'Fields' => '栏',
    'File Name' => '档案名称',
    'File Path' => '档案路径',
    'Find Media' => '搜寻媒体',
    'Find Stories' => '搜寻稿件',
    'Find Templates' => '搜寻模板',
    'First Name' => '名',
    'First Published' => => '第一个出版的',
    'First' => '第一',
    'Fixed' => '固定的',
    'Generic' => '通用的',
    'Grant "[_1]" members permission to access assets in these categories.' => '允许 [_1] 成员权限得以存取这些分类里面的资产。',
    'Grant "[_1]" members permission to access assets in these workflows.' => '允许 [_1] 成员权限能够存取这些流程里面的资产。',
    'Grant "[_1]" members permission to access assets on these desks.' => '允许 [_1] 成员权限得以存取这些桌面的资产。',
    'Grant "[_1]" members permission to access the members of these groups.' => '允许 [_1] 成员之权限得以存取这些群组里面之成员',
    'Grant the members of the following groups permission to access the members of the "[_1]" group.' => '允许以下群组的成员得以存取 [_1] 群组的成员。',
    'Group Label' => '群组标记',
    'Group Manager' => '群组管理',
    'Group Memberships' => '群组成员',
    'Group Type' => '群组类型',
    'Group cannot be deleted' => '不能删除群组',
    'Group profile "[_1]" deleted.' => '群组设定 [_1] 已删除。',
    'Group profile "[_1]" saved.' => '群组设定 [_1] 以储存',
    'Groups' => '群组',
    'High'=> '最高',
    'Hour' => '时',
    'ID' => 'ID',
    'Invalid date value for "[_1]" field.' => '日期栏位「[_1]」的值无效',
    'Invalid page request' => '无效的页面要求',
    'Invalid password. Please try again.' => '密码无效，请再试一次',
    'Invalid username or password. Please try again.' => '使用者名称或者密码无效，请再试一次。',
    'Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec' => '一月 二月 三月 四月 五月 六月 七月 八月 九月 十月 十一月 十二月',
    'Jan' => '一月',
    'Job Manager' => '工作管理',
    'Job profile "[_1]" deleted.' => '工作设定 [_1] 已删除。',
    'Job profile "[_1]" saved.' => '工作设定 [_1] 已储存。',
    'Jobs' => '工作',
    'Jul' => '七月',
    'Jun' => '六月',
    'Keywords saved.' => '关键字已储存。',
    'Label' => '标记',
    'Last Name' => '姓',
    'Last' => '最后',
    'Log' => '纪录',
    'Login "[_1]" contains invalid characters.' => '登入帐号 [_1] 内含非法字元啊！',
    'Login "[_1]" is already in use. Please try again.' => '登入 [_1] 已被使用，请再试一次。',
    'Login ' => '登入',
    'Login and Password' => '登入及密码',
    'Login cannot be blank. Please enter a login.' => '登入栏位不能留白，请务必正确输入',
    'Login must be at least [_1] characters.' => '登入帐号至少要有 [_1] 个字符',
    'Login' => '登入帐号',
    'Low'     => '最低',
    'MEDIA FOUND' => '找到媒体',
    'MEDIA' => '媒体 ',
    'Manage' => '管理',
    'Manager' => '管理员',
    'Mar' => '三月',
    'Maximum size' => '最大',
    'May' => '五月',
    'Media "[_1]" check out canceled.' => '已取消取出媒体 [_1] 。',
    'Media "[_1]" created and saved.' => '媒体 [_1] 已建立，并且储存。',
    'Media "[_1]" deleted.' => '媒体 [_1] 已删除。',
    'Media "[_1]" published.' => 'Media [_1] 已正式公开出版。',
    'Media "[_1]" reverted to V.[_2]' => '媒体 [_1] 已回复到第 [_2] 版',
    'Media "[_1]" saved and checked in to "[_2]".' => '媒体 [_1] 已储存，并送回到 [_2].',
    'Media "[_1]" saved and moved to "[_2]".' => '媒体 [_1] 已储存，并且移动到 [_2]。',
    'Media "[_1]" saved and moved to "[_2]".' => '媒体 [_1] 以储存，且移动至 [_2]。',
    'Media "[_1]" saved and shelved.' => '媒体 [_1] 已储存且上架了。',
    'Media "[_1]" saved.' => '媒体 [_1] 已储存。',
    'Media Type Manager' => '媒体类型管理',
    'Media Type profile "[_1]" deleted.' => '媒体型别设定 [_1] 已经储存。',
    'Media Type profile "[_1]" saved.' => '媒体型别 [_1] 已储存。',
    'Media Type' => '媒体类型',
    'Media Type Element' => '媒体类型',
    'Media Types' => '媒体型别',
    'Medium High' => '较高',
    'Medium Low' => '较低 ',
    'Member Type  ' => '成员类型',
    'Members' => '成员',
    'Minute' => '分',
    'Month' => '月',
    'Move Assets' => '移动资产',
    'Move to Desk' => '移到桌面',
    'Move to' => '移到',
    'My Alerts' => '我的警告',
    'My Workspace' => '我的工作区',
    'NAME' => '名称',
    'Name is required.' => '名称为必要的。',
    'Name' => '名称',
    'New Media' => '新增媒体',
    'New Role Name' => '新角色名称',
    'New Story' => '新增稿件',
    'New Template' => '新增样板',
    'New password' => '新密码',
    'New passwords do not match. Please try again.' => '新密码不符，请再输入一次',
    'New' => '新的',
    'No alert types were found' => '找不到警告型别',
    'No categories were found' => '找不到分类',
    'No contributor types were found' => '找不到供稿者型别',
    'No contributors defined' => '未有定义好的供稿者',
    'No contributors defined.' => '未定义任何供稿者',
    'No destinations were found' => '找不到目标',
    'No element types were found' => '找不到元素型别设定',
    'No elements are present.' => '找不到元素',
    'No elements have been added.' => '没有加入任何元素。',
    'No elements were found' => '找不到元素',
    'No existing notes.' => '并无注意事项',
    'No file associated with media "[_1]". Skipping.' => '「[_1]」媒体并无相关的档案，在此略过。',
    'No file has been uploaded' => '没有任何以上传的档案。',
    'No groups were found' => '找不到群组',
    'No jobs were found' => '找不到工作',
    'No keywords defined.' => '未定义任何关键字',
    'No media file is associated with asset "[_1]", so none will be distributed.' => '由于 [_1] 资产完全没有相关的媒体档案，所以并不会将档案散布出去。',
    'No media types were found' => '找不到媒体型别',
    'No media were found' => '找不到媒体',
    'No output channels were found' => '并没有找到任何输出频道',
    'No output to preview.' => '无预览输出',
    'No related Stories' => '无相关的稿件',
    'No sources were found' => '找不到来源',
    'No stories were found' => '找不到任何稿件',
    'No templates were found' => '找不到样板',
    'No users were found' => '找不到使用者',
    'No workflows were found' => '找不到流程',
    'No' => '否',
    'Normal'  => '正常',
    'Note saved.' => '注意事项已储存.',
    'Note' => '注意事项',
    'Note: Container element "[_1]" removed in bulk edit but will not be deleted.' => '注意：容器元素「[_1]」在大量编辑模式中被去掉了，但它并不会被删除。',
    'Note: Data element "[_1]" is required and cannot be completely removed.  Will delete all but one.' => '注意：资料元素「[_1]」为必要的，因此不能全部被移除，将会留下其中一个。',
    'Notes'  => '注意事项',
    'Nov' => '十一月',
    'Object Group Permissions' => '对象群组权限',
    'Oct' => '十月',
    'Old password' => '旧密码',
    'Options, Label' => '选项、标记',
    'Or Pick a Type' => '或选择一个型别',
    'Order' => '顺序',
    'Organization' => '组织',
    'Output Channel profile "[_1]" deleted.' => '输出频道设定 [_1] 已删除。',
    'Output Channel profile "[_1]" saved.' => '输出频道 [_1] 已被储存。',
    'Output Channel' => '输出频道',
    'Output Channels' => '输出频道',
    'Owner' => '所有者',
    'PENDING JOBS' => '待办工作',
    'PLEASE LOG IN' => '请登录',
    'PREFERENCES' => '偏好设定',
    'PROPERTIES' => '特性',
    'PROPERTIES' => '特性',
    'PUBLISHING' => '出版',
    'Page' => '页',
    'Paragraph' => '段',
    'Parent cannot choose itself or its child as its parent. Try a different parent.' => '一个节点不能把自己或其子节点设定为自己的母节点，请选择别的节点。',
    'Password contains illegal preceding or trailing spaces. Please try again.' => '密码前后有非法的空白字元，请再试一次。',
    'Password'  => '密码',
    'Passwords cannot have spaces at the beginning!' => '密码开头不能是空白字符啊！',
    'Passwords cannot have spaces at the end!' => '密码最后不能有空白字符啊！',
    'Passwords do not match!�  Please re-enter.' => '密码不匹配！请重新输入。',
    'Passwords must be at least [_1] characters!' => '密码至少要有 [_1] 个字符！',
    'Passwords must match!' => '密码一定要匹配',
    'Pending ' => '待办',
    'Permission Denied' => '权限遭拒绝',
    'Permission to checkout "[_1]" denied.' => '取出 [_1] 的权限遭拒绝',
    'Permission to delete "[_1]" denied.' => '删除 [_1] 权限遭拒绝',
    'Permissions saved.' => '权限已储存',
    'Please check the URL and try again. If you feel you have reached this page as a result of a server error or other bug, please notify the server administrator. Be sure to include as much detail as possible, including the type of browser, operating system, and the steps leading up to your arrival here.' => '请仔细检查URL并且再试一次。如果你觉得你是因为某种服务器产生的错误而来到这个页面，请尽速通知管理员，并请附上尽量详细的信息，包括使用的浏览器、操作系统、以及达到这一页的每个步骤。',
    'Please select a primary category.' => '请选择一个主要的分类',
    'Please select a story type.' => '请选择一个稿件类型',
    'Position' => '位置',
    'Post' => 'Post', # XXX: Chinese name scheme don't have this 2 field.
    'Pre' => 'Pre',
    'Preference "[_1]" updated.' => '偏好设定 [_1] 已更新。',
    'Preference Manager' => '偏好设定管理',
    'Preferences' => '偏好设定',
    'Prefix' => 'Prefix',
    'Preview in' => '预览',
    'Previews' => '预览',
    'Primary Category' => '主要的分类',
    'Primary Output Channel' => '主要的输出频道',
    'Priority' => '优先权',
    'Problem adding "[_1]"' => '增加 [_1] 时发生问题',
    'Problem deleting "[_1]"' => '删除 [_1] 时发生问题。',
    'Profile' => '设定',
    'Properties' => '特性',
    'Publish Date' => '出版日期',
    'Publish Desk' => '出版桌面',
    'Publish' => '出版',
    'Published Version' => '出版的版本',
    'Publishes' => '出版品',
    'Recipients' => '收件者',
    'Redirecting to preview.' => '重导到御览',
    'Relate' => '加入关系',
    'Related Media' => '相关的媒体',
    'Related Story' => '相关的稿件',
    'Repeat new password' => '新密码确认',
    'Repeatable' => '可重复的',
    'Required' => '必要的',
    'Resources' => '资源',
    'Role' => '角色',
    'Roles' => '角色',
    'Rows' => '列',
    'SEARCH' => '寻找',
    'STORIES FOUND' => '找到的稿件',
    'STORIES' => '稿件',
    'STORY INFORMATION' => '稿件信息',
    'STORY' => '稿件',
    'SUBMIT' => '送出',
    'SYSTEM' => '系统',
    'Scheduled Time' => '排定的时间',
    'Scheduler' => 'Scheduler',
    'Select Desk' => '选一个桌面',
    'Select Role' => '选择角色',
    'Select an Event Type' => '选择一个事件型别',
    'Select' => '选择',
    'Sep' => '九月',
    'Separator Changed.' => '分隔字元已更动。',
    'Separator String' => '分隔字串',
    'Server profile "[_1]" deleted.' => '服务器设定 [_1] 已经储存。',
    'Server profile "[_1]" saved.' => '服务器设定 [_1] 已储存。',
    'Simple Search' => '简易查找',
    'Site profile "[_1]" deleted.' => '站点设定「[_1]」已删除',
    'Site profile "[_1]" saved.' => '站点设定「[_1]」已储存',
    'Size' => '大小',
    'Slug must conform to URI character rules.' => 'Slug 也一定要依循 URI 字符的规则',
    'Slug required for non-fixed (non-cover) story type.' => 'Slug 栏位，在非固定的（非封面）故事类型之中是必要的',
    'Sort By' => '排序方式',
    'Source Manager' => '来源管理',
    'Source name' => '来源名称',
    'Source profile "[_1]" deleted.' => '来源设定 [_1] 已删除。',
    'Source profile "[_1]" saved.' => '来源设定 [_1] 已储存。',
    'Source' => '来源',
    'Sources' => '来源',
    'Start Desk' => '开始桌面',
    'Statistics' => '统计',
    'Status' => '状态',
    'Stories in this category' => '这个分类里面的稿件',
    'Story "[_1]" check out canceled.' => '取消取出稿件 [_1]。',
    'Story "[_1]" created and saved.' => '稿件 [_1] 已建立，并且储存。',
    'Story "[_1]" deleted.' => '稿件 [_1] 已删除。',
    'Story "[_1]" published.' => '稿件 [_1] 已出版。',
    'Story "[_1]" reverted to V.[_2].' => '稿件 [_1] 已回复到第 [_2] 版。',
    'Story "[_1]" saved and checked in to "[_2]".' => '稿件 [_1] 已经储存且送回至 [_2]。',
    'Story "[_1]" saved and checked in to "[_2]".' => '稿件 [_1] 已储存，送回至 [_1] 。',
    'Story "[_1]" saved and moved to "[_2]".' => '稿件 [_1] 已储存，移动至 [_2] 。',
    'Story "[_1]" saved and shelved.' => '稿件 [_1] 已储存且上架了。',
    'Story "[_1]" saved.' => '稿件 [_1] 已储存。',
    'Story Type' => '稿件型别',
    'Story Type Element' => '稿件类型',
    'Subelements' => '子元素',
    'Switch Roles' => '变换角色',
    'TEMPLATE' => '样板',
    'TEMPLATES FOUND' => '找到的模板',
    'Teaser' => '悬疑广告',
    'Template "[_1]" check out canceled.' => '取消取出样板 [_1]。',
    'Template "[_1]" deleted.' => '模板 [_1] 已删除。',
    'Template "[_1]" saved and moved to "[_2]".' => '模板 [_1] 已建立，并且移动至 [_2]',
    'Template "[_1]" saved and shelved.' => '模板 [_1] 已建立，并且上架了',
    'Template "[_1]" saved.' => '模板 [_1] 已储存。',
    'Template Includes' => '模板包括了...',
    'Template Name' => '模板名称',
    'Template compile failed: [_1]' => '模板编译失败: [_1]',
    'Template deployed.' => '模板已经配备完成',
    'Text Area' => '文字区域',
    'Text box' => '文字方块',
    'The URI of this media conflicts with that of [_1].  Please change the category, file name, or slug.' => '此媒体的 URI 与 [_1] 的 URI 相同，请调整分类、档案名称、或者 slug。',
    'The URL you requested, <b>[_1]</b>, was not found on this server' => '在这台服务器上，并没有找到所求之 URL <b>[_1]</b> ',
    'The category was not added, as it would have caused a URI clash with story [_1].' => '分类并没有加入，因为会造成与稿件「[_1]」相同的URI。',
    'The cover date has been reverted to [_1], as it caused this story to have a URI conflicting with that of story \'[_2].' => '见报日期已经回复到 [_1] ，因为原本这篇稿子的 URI 与 \'[_2]\' 这篇稿子相同。 ',
    'The key name "[_1]" is already used by another ???.' => '键值名称「_1」似乎已经被使用了。',
    'The name "[_1]" is already used by another Alert Type.' => '「[_1]」这个名称已经被其他的警告类型使用了',
    'The name "[_1]" is already used by another Desk.' => '「[_1]」这个名称已经被其他的桌面使用了',
    'The name "[_1]" is already used by another Destination.' => '「[_1]」这个名称已经被其他的发布目标使用了',
    'The name "[_1]" is already used by another Element Type.' => '[_1] 这名称已经被其他的元素类型使用。',
    'The name "[_1]" is already used by another Media Type.' => '[_1] 这个名称已被其他的媒体类型占用。',
    'The name "[_1]" is already used by another Output Channel.' => '[_1] 这个名字已经被其他的输出频道使用了',
    'The name "[_1]" is already used by another Source.' => '[_1] 这个名称已经被其他的来源采用',
    'The name "[_1]" is already used by another Workflow.' => '其他流程已经使用了 [_1] 这个名字',
    'The slug can only contain alphanumeric characters (A-Z, 0-9, - or _)!' => 'Slug 里面只能用英文字母、阿拉伯数字、短线、与底线字符！',
    'The slug has been reverted to [_1], as the slug [_2] caused this story to have a URI conflicting with that of story [_3].' => '此 Slug 已被回复到 [_1]，因为 Slug [_2] 使得这篇稿件的 URI 与「[_3]」这篇稿件的 URI 相同。',
    'The slug, category and cover date you selected would have caused this story to have a URI conflicting with that of story [_1].' => '这篇稿件所选的的 slug、分类、以及见报日期，将使其 URI 与「[_1]」这篇稿件相同',
    'This day does not exist! Your day is changed to the' => '这一天根本不存在啊！它已经被改为',
    'This story has not been assigned to a category.' => '这份稿件目前尚未被分类',
    'Timestamp'   => '时间',
    'Title' => '标题',
    'Trail'  => '更改纪录',
    'Triggered By' => '触发者',
    'Type' => '类型',
    'URI "[_1]" is already in use. Please try a different directory name or parent category.' => 'URI [_1] 已被使用，请调整目录名称或者是分类。',
    'URI' => 'URI',
    'URL' => 'URL',
    'Un-relate' => '解除关系',
    'User Manager' => '使用者管理',
    'User Override' => '变身为别的使用者',
    'User profile "[_1]" deleted.' => '使用者设定 [_1] 已删除。',
    'User profile "[_1]" saved.' => '使用者设定「[_1]」已储存',
    'Username' => '使用者名称',
    'Usernames must be at least 6 characters!' => '使用者名称至少需要六个字符',
    'Users' => '使用者',
    'Using Cyclops without JavaScript can result in corrupt data and system instability. Please activate JavaScript in your browser before continuing.' => '在未启用 JavaScript 时使用 Cyclops 可能会导致资料损毁、系统不稳定等状况，请立刻启动浏览器的JavaScript。',
    'Value Name' => '值',
    'View' => '看看',
    'Warning! Cyclops is designed to run with JavaScript enabled.' => '警告！执行Cyclops必须同时启动JavaScript才行！',
    'Warning! State inconsistent: Please use the buttons provided by the application rather than the \'Back\'/\'Forward\' buttons.' => '警告！状态产生矛盾：请务必利用本程序所给的按钮，不要用浏览器的「向前」「向后」按钮。',
    'Warning:  Use of element\'s \'name\' field is deprecated for use with element method \'get_container\'.  Please use the element\'s \'key_name\' field instead.' => '警告：以元素的 get_container 方法取得 \'name\' 栏位的用法已经过时了，请改用元素的 \'key_name\' 栏位。',
    'Warning:  Use of element\'s \'name\' field is deprecated for use with element method \'get_data\'.  Please use the element\'s \'key_name\' field instead.' => '警告：以元素的 get_data 方法取得 \'name\' 栏位的用法已经过时了，请改用元素的 \'key_name\' 栏位。',
    'Warning: object "[_1]" had no associated desk.  It has been assigned to the "[_2]" desk.' => '警告：[_1] 没有所属的桌面，它已经被移动到 [_2] 这个桌面。',
    'Warning: object "[_1]" had no associated workflow.  It has been assigned to the "[_2]" workflow. This change also required that this object be moved to the "[_3]" desk.' => '警告：「[_1]」对象并不属于任何流程，所以已经被放入「[_2]」流程中。此项异动同时已把对象移到「[_3]」桌面。',
    'Warning: object "[_1]" had no associated workflow.  It has been assigned to the "[_2]" workflow.' => '警告：「[_1]」对象并不属于任何流程，所以已经被放入「[_2]」流程中。',
    'Welcome to Bricolage.' => '欢迎使用 Bricolage',
    'Welcome to Cyclops.' => '欢迎来到 Cyclops.',
    'Words' => '字',
    'Workflow Manager' => '流程管理',
    'Workflow Permissions' => '流程权限',
    'Workflow profile [_1] deleted.' => '流程设定 [_1] 已删除。',
    'Workflow profile [_1] saved.' => '流程设定 [_1] 已储存。',
    'Workflow' => '流程',
    'Workflows' => '流程',
    'Workspace for [_1]' => '[_1] 的工作区',
    'Writing files to "[_1]" Output Channel.' => '正将档案写至「[_1]」输出频道',
    'Year' => '年',
    'Yes' => '是',
    'You are about to permanently delete items! Do you wish to continue?' => '这些项目将被永久删除！真的要继续吗？',
    'You cannot remove all Sites.' => '不能移除所有站点',
    'You have not been granted <b>[_1]</b> access to the <b>[_2]</b> [_3]' => '您并未允许 <b>[_1]</b> 存取 <b>[_2]</b> [_3]',
    'You must be an administrator to use this function.' => '此功能只有管理员才可行使',
    'You must select an Element or check the &quot;Generic&quot; check box.' => '你必须选择一个元素，或是核选「通用」的核选方块',
    'You must select an Element.' => '您必须选择一个元素',
    'You must supply a unique name for this role!' => '你必须替这个角色取个独一无二的名字',
    'You must supply a value for ' => '您必须给定其值',
    '[_1] Field Text' => '[_1] 栏位文字',
    '[_1] recipients changed.' => '[_1] 个收件者已更动。',
    '[quant,_1,Alert] acknowledged.' => '警告已被确认',
    '[quant,_1,Contributor] "[_2]" associated.' => '已关联至此供稿者：「[_2]」',
    '[quant,_1,Template] deployed.' => '模板已经配备完成',
    '[quant,_1,media,media] published.'   => '[_1] 个媒体出版完成。',
    '[quant,_1,story,stories] published.' => '[_1] 篇稿件出版完成。' ,
    'all' => '全部',
    'one per line' => '一行一个',
    'to' => '到',
   '_AUTO' => 1,
);

=begin comment

To translate:
  '[_1] Site [_2] Permissions' => '[_1] [_2] Permissions', # Site Category Permissions
  'All Categories' => 'All Categories',
  'All' => 'All',
  'Object Groups' => 'Object Groups',
  '[_1] Site Categories' => '[_1] Site Categories',
  'You do not have permission to override user "[_1]"' => 'You do not have permission to override user "[_1]"',
  'Please select a primary output channel' => 'Please select a primary output channel',
  'Not defined.' => 'Not defined.',
  'Milliseconds' => 'Milliseconds',
  'Microseconds' => 'Microseconds',
  'Not defined.' => 'Not defined.',
  "You do not have sufficient permission to create a media document for this site" => "You do not have sufficient permission to create a media document for this site"
  'The primary category cannot be deleted.' => 'The primary category cannot be deleted.',
  'Cannot make a dissociated category the primary category.' => 'Cannot make a dissociated category the primary category.'
  'Related [_1] "[_2]" is not activate. Please relate another [_1].' => 'Related [_1] "[_2]" is not activate. Please relate another [_1].'
  'Cannot auto-publish related $rel_disp_name "[_1]" because it is not on a publish desk.' => 'Cannot auto-publish related $rel_disp_name "[_1]" because it is not on a publish desk.'

=end comment

=cut

1;

__END__

=head1 AUTHOR

Kang-min Liu <gugod@gugod.org>, Gang Luo <lgjut@sohu.com>

=head1 SEE ALSO

L<Bric::Util::Language|Bric::Util::Language>

=cut

1;
