(*
    My Projects: https://github.com/superbot-coder?tab=repositories
    Telegram channel: https://t.me/delphi_solutions
    Telegram chat: https://t.me/delphi_solutions_chat
    Date: 2026.09.03
 *)

unit GitHub.ResponseTypes;

interface

USES
    Rest.Json.Types;

type

 TRepositryLicense = class
 private
   [JsonName('key')]
   FKey: string;
   [JsonName('name')]
   FName: string;
   [JsonName('spdx_id')]
   FSpdxId: string;
   [JsonName('url')]
   FUrl: string;
   [JsonName('node_id')]
   FNodeId: string;
 public
   property Key: string read FKey write  FKey;
   property Name: string read FName write Fname;
   property SpdxId: string read FSpdxId write FSpdxId;
   property Url: string read FUrl write FUrl;
   property NodeId: string read FNodeId write FNodeId;
 end;

  TRepositoryOwner = class
  Protected
    [JsonName('login')]
		FLogin             : String;
    [JsonName('id')]
		FId                : UInt64;
    [JsonName('node_id')]
		FNodeId            : string;
    [JsonName('avatar_url')]
		FAvatarUrl         : string;
    [JsonName('gravatar_id')]
		FGravatarId        : string;
    [JsonName('url')]
		FUrl               : string;
    [JsonName('html_url')]
		FHtmlUrl           : string;
    [JsonName('followers_url')]
		FFollowersUrl      : string;
    [JsonName('following_url')]
		FFollowingUrl      : string;
    [JsonName('gists_url')]
		FGistsUrl          : string;
    [JsonName('starred_url')]
		FStarredUrl        : string;
    [JsonName('subscriptions_url')]
		FSubscriptionsUrl  : string;
    [JsonName('organizations_url')]
		FOrganizationsUrl  : string;
    [JsonName('repos_url')]
		FReposUrl          : string;
    [JsonName('events_url')]
		FEventsUrl         : string;
    [JsonName('received_events_url')]
		FReceivedEventsUrl : string;
    [JsonName('type')]
		FType              : string;
    [JsonName('user_view_type')]
		FUserViewType      : string;
    [JsonName('site_admin')]
		FSiteAdmin          : Boolean;
  Public
		property Login: String read FLogin write Flogin;
    property Id: UInt64 read FId write FId;
		property NodeId: string read FNodeId write FNodeId;
		property AvatarUrl: string read FAvatarUrl write FAvatarUrl;
		property GravatarId: string read FGravatarId write FGravatarId;
		property Url: string read FUrl write FUrl;
		property HtmlUrl : string read FHtmlUrl write FHtmlUrl;
		property FollowersUrl: string read FFollowersUrl write FFollowersUrl;
		property FollowingUrl: string read FFollowingUrl write FFollowingUrl;
		property GistsUrl: string read FGistsUrl write FGistsUrl;
		property StarredUrl: string read FGistsUrl write FGistsUrl;
		property SubscriptionsUrl: string read FSubscriptionsUrl write FSubscriptionsUrl;
		property OrganizationsUrl: string read FOrganizationsUrl write FOrganizationsUrl;
		property ReposUrl: string read FReposUrl write FReposUrl;
		property EventsUrl: string read FEventsUrl write FEventsUrl;
		property ReceivedEventsUrl: string read FReceivedEventsUrl write FReceivedEventsUrl;
		property OwnerType: string read FType write FType;
		property UserViewType: string read FUserViewType write FUserViewType;
		property SiteAdmin: Boolean read FSiteAdmin write FSiteAdmin;
  end;

  TFoundRepository = class
  private
    [JsonName('id')]
    FId: UInt64;
    [JsonName('node_id')]
    FNodeId: string;
    [JsonName('name')]
    FName: string;
    [JsonName('full_name')]
    FFullName: string;
    [JsonName('private')]
    FPrivate: Boolean;
    [JsonName('owner')]
    FOwner: TRepositoryOwner;
    [JsonName('html_url')]
    FHtmlUrl: string;
    [JsonName('description')]
    FDescription: string;
    [JsonName('fork')]
    FFork: Boolean;
    [JsonName('url')]
    FUrl: string;
    [JsonName('forks_url')]
    FForksUrl: string;
    [JsonName('keys_url')]
    FKeysUrl: string;
    [JsonName('collaborators_url')]
    FCollaboratorsUrl: string;
    [JsonName('teams_url')]
    FTeamsUrl: string;
    [JsonName('hooks_url')]
    FHooksUrl: string;
    [JsonName('issue_events_url')]
    FIssueEventsUrl: string;
    [JsonName('events_url')]
    FEventsUrl: string;
    [JsonName('assignees_url')]
    FAssigneesUrl: string;
    [JsonName('branches_url')]
    FBranchesUrl: string;
    [JsonName('tags_url')]
    FTagsUrl: string;
    [JsonName('blobs_url')]
    FBlobsUrl: string;
    [JsonName('git_tags_url')]
    FGitTagsUrl: string;
    [JsonName('git_refs_url')]
    FGitRefsUrl: string;
    [JsonName('trees_url')]
    FTreesUrl: string;
    [JsonName('statuses_url')]
    FStatusesUrl: string;
    [JsonName('languages_url')]
    FLanguagesUrl: string;
    [JsonName('stargazers_url')]
    FStargazersUrl: string;
    [JsonName('contributors_url')]
    FContributorsUrl: string;
    [JsonName('subscribers_url')]
    FSubscribersUrl: string;
    [JsonName('subscription_url')]
    FSubscriptionUrl: string;
    [JsonName('commits_url')]
    FCommitsUrl: string;
    [JsonName('git_commits_url')]
    FGitCommitsUrl: string;
    [JsonName('comments_url')]
    FCommentsUrl: string;
    [JsonName('issue_comment_url')]
    FIssueCommentUrl: string;
    [JsonName('contents_url')]
    FContentsUrl: string;
    [JsonName('compare_url')]
    FCompareUrl: string;
    [JsonName('merges_url')]
    FMergesUrl: string;
    [JsonName('archive_url')]
    FArchiveUrl: string;
    [JsonName('downloads_url')]
    FDownloadsUrl: string;
    [JsonName('issues_url')]
    FIssuesUrl: string;
    [JsonName('pulls_url')]
    FPullsUrl: string;
    [JsonName('milestones_url')]
    FMilestonesUrl: string;
    [JsonName('notifications_url')]
    FNotificationsUrl: string;
    [JsonName('labels_url')]
    FLabelsUrl: string;
    [JsonName('releases_url')]
    FReleasesUrl: string;
    [JsonName('deployments_url')]
    FDeploymentsUrl: string;
    [JsonName('created_at')]
    FCreatedAt: TDateTime;
    [JsonName('updated_at')]
    FUpdatedAt: TDateTime;
    [JsonName('pushed_at')]
    FPushedAt: TDateTime;
    [JsonName('git_url')]
    FGitUrl: string;
    [JsonName('ssh_url')]
    FSshUrl: string;
    [JsonName('clone_url')]
    FCloneUrl: string;
    [JsonName('svn_url')]
    FSvnUrl: string;
    [JsonName('homepage')]
    FHomepage: string;
    [JsonName('size')]
    FSize: Integer;
    [JsonName('stargazers_count')]
    FStargazersCount: Integer;
    [JsonName('watchers_count')]
    FWatchersCount: Integer;
    [JsonName('language')]
    FLanguage: string;
    [JsonName('has_issues')]
    FHasIssues: Boolean;
    [JsonName('has_projects')]
    FHasProjects: Boolean;
    [JsonName('has_downloads')]
    FHasDownloads: Boolean;
    [JsonName('has_wiki')]
    FHasWiki: Boolean;
    [JsonName('has_pages')]
    FHasPages: Boolean;
    [JsonName('has_discussions')]
    FHasDiscussions: Boolean;
    [JsonName('forks_count')]
    FForksCount: Integer;
    [JsonName('mirror_url')]
    FMirrorUrl: string;
    [JsonName('archived')]
    FArchived: Boolean;
    [JsonName('disabled')]
    FDisabled: Boolean;
    [JsonName('open_issues_count')]
    FOpenIssuesCount: Integer;
    [JsonName('license')]
    FLicense: TRepositryLicense;
    [JsonName('allow_forking')]
    FAllowForking: Boolean;
    [JsonName('is_template')]
    FIsTemplate: Boolean;
    [JsonName('web_commit_signoff_required')]
    FWebCommitSignoffRequired: Boolean;
    [JsonName('has_pull_requests')]
    FHasPullRequests: Boolean;
    [JsonName('pull_request_creation_policy')]
    FPullRequestCreationPolicy: string;
    [JsonName('topics')]
    FTopics: TArray<string>;
    [JsonName('visibility')]
    FVisibility: string;
    [JsonName('forks')]
    FForks: Integer;
    [JsonName('open_issues')]
    FOpenIssues: Integer;
    [JsonName('watchers')]
    FWatchers: Integer;
    [JsonName('default_branch')]
    FDefaultBranch: string;
    [JsonName('scope')]
    FScore: Double;
  public
    property Id: UInt64 read FId write FId;
    property NodeId: string read FNodeId write FNodeId;
    property Name: string read FName write FName;
    property FullName: string read FFullName write FFullName;
    property Private_: Boolean read FPrivate write FPrivate;
    property Owner: TRepositoryOwner read FOwner write FOwner;
    property HtmlUrl: string read FHtmlUrl write FHtmlUrl;
    property Description: string read FDescription write FDescription;
    property Fork: Boolean read FFork write FFork;
    property Url: string read FUrl write FUrl;
    property ForksUrl: string read FForksUrl write FForksUrl;
    property KeysUrl: string read FKeysUrl write FKeysUrl;
    property CollaboratorsUrl: string read FCollaboratorsUrl write FCollaboratorsUrl;
    property TeamsUrl: string read FTeamsUrl write FTeamsUrl;
    property HooksUrl: string read FHooksUrl write FHooksUrl;
    property IssueEventsUrl: string read FIssueEventsUrl write FIssueEventsUrl;
    property EventsUrl: string read FEventsUrl write FEventsUrl;
    property AssigneesUrl: string read FAssigneesUrl write FAssigneesUrl;
    property BranchesUrl: string read FBranchesUrl write FBranchesUrl;
    property TagsUrl: string read FTagsUrl write FTagsUrl;
    property BlobsUrl: string read FBlobsUrl write FBlobsUrl;
    property GitTagsUrl: string read FGitTagsUrl write FGitTagsUrl;
    property GitRefsUrl: string read FGitRefsUrl write FGitRefsUrl;
    property TreesUrl: string read FTreesUrl write FTreesUrl;
    property StatusesUrl: string read FStatusesUrl write FStatusesUrl;
    property LanguagesUrl: string read FLanguagesUrl write FLanguagesUrl;
    property StargazersUrl: string read FStargazersUrl write FStargazersUrl;
    property ContributorsUrl: string read FContributorsUrl write FContributorsUrl;
    property SubscribersUrl: string read FSubscribersUrl write FSubscribersUrl;
    property SubscriptionUrl: string read FSubscriptionUrl write FSubscriptionUrl;
    property CommitsUrl: string read FCommitsUrl write FCommitsUrl;
    property GitCommitsUrl: string read FGitCommitsUrl write FGitCommitsUrl;
    property CommentsUrl: string read FCommentsUrl write FCommentsUrl;
    property IssueCommentUrl: string read FIssueCommentUrl write FIssueCommentUrl;
    property ContentsUrl: string read FContentsUrl write FContentsUrl;
    property CompareUrl: string read FCompareUrl write FCompareUrl;
    property MergesUrl: string read FMergesUrl write FMergesUrl;
    property ArchiveUrl: string read FArchiveUrl write FArchiveUrl;
    property DownloadsUrl: string read FDownloadsUrl write FDownloadsUrl;
    property IssuesUrl: string read FIssuesUrl write FIssuesUrl;
    property PullsUrl: string read FPullsUrl write FPullsUrl;
    property MilestonesUrl: string read FMilestonesUrl write FMilestonesUrl;
    property NotificationsUrl: string read FNotificationsUrl write FNotificationsUrl;
    property LabelsUrl: string read FLabelsUrl write FLabelsUrl;
    property ReleasesUrl: string read FReleasesUrl write FReleasesUrl;
    property DeploymentsUrl: string read FDeploymentsUrl write FDeploymentsUrl;
    property CreatedAt: TDateTime read FCreatedAt write FCreatedAt;
    property UpdatedAt: TDateTime read FUpdatedAt write FUpdatedAt;
    property PushedAt: TDateTime read FPushedAt write FPushedAt;
    property GitUrl: string read FGitUrl write FGitUrl;
    property SshUrl: string read FSshUrl write FSshUrl;
    property CloneUrl: string read FCloneUrl write FCloneUrl;
    property SvnUrl: string read FSvnUrl write FSvnUrl;
    property Homepage: string read FHomepage write FHomepage;
    property Size: Integer read FSize write FSize;
    property StargazersCount: Integer read FStargazersCount write FStargazersCount;
    property WatchersCount: Integer read FWatchersCount write FWatchersCount;
    property Language: string read FLanguage write FLanguage;
    property HasIssues: Boolean read FHasIssues write FHasIssues;
    property HasProjects: Boolean read FHasProjects write FHasProjects;
    property HasDownloads: Boolean read FHasDownloads write FHasDownloads;
    property HasWiki: Boolean read FHasWiki write FHasWiki;
    property HasPages: Boolean read FHasPages write FHasPages;
    property HasDiscussions: Boolean read FHasDiscussions write FHasDiscussions;
    property ForksCount: Integer read FForksCount write FForksCount;
    property MirrorUrl: String read FMirrorUrl write FMirrorUrl;
    property Archived: Boolean read FArchived write FArchived;
    property Disabled: Boolean read FDisabled write FDisabled;
    property OpenIssuesCount: Integer read FOpenIssuesCount write FOpenIssuesCount;
    property License: TRepositryLicense read FLicense write FLicense;
    property AllowForking: Boolean read FAllowForking write FAllowForking;
    property IsTemplate: Boolean read FIsTemplate write FIsTemplate;
    property WebCommitSignoffRequired: Boolean read FWebCommitSignoffRequired write FWebCommitSignoffRequired;
    property HasPullRequests: Boolean read FHasPullRequests write FHasPullRequests;
    property PullRequestCreationPolicy: string read FPullRequestCreationPolicy write FPullRequestCreationPolicy;
    property Topics: TArray<String> read FTopics write FTopics;
    property Visibility: string read FVisibility write FVisibility;
    property Forks: Integer read FForks write FForks;
    property OpenIssues: Integer read FOpenIssues write FOpenIssues;
    property Watchers: Integer read FWatchers write FWatchers;
    property DefaultBranch: string read FDefaultBranch write FDefaultBranch;
    property Score: Double read FScore write FScore;

    constructor Create;
    destructor Destroy; Override;
  end;


implementation

{ TFoundRepository }

constructor TFoundRepository.Create;
begin
  inherited Create;
  FOwner := TRepositoryOwner.Create;
  FLicense := TRepositryLicense.Create;
end;

destructor TFoundRepository.Destroy;
begin
  FOwner.Free;
  FLicense.Free;
  Inherited Destroy;
end;

end.
