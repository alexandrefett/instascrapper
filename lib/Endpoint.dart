class Endpoint {
  static const String REFERER = "Referer";
  static const String X_INSTAGRAM_GIS = "X-Instagram-gis";
  static const String BASE_URL = "https://www.instagram.com/";
  static const String LOGIN_URL = "https://www.instagram.com/accounts/login/ajax/";
  static const String MEDIA_LINK = "https://www.instagram.com/p/{{code}}";
  static const String ACCOUNT_JSON_INFO = "https://www.instagram.com/{{username}}/?__a=1";
  static const String ACCOUNT_MEDIAS = "https://instagram.com/graphql/query/?query_id=17888483320059182&id={{userId}}&first=30&after={{maxId}}";
  static const String TAG_JSON_INFO = "https://www.instagram.com/explore/tags/{{tag_name}}/?__a=1";
  static const String MEDIA_JSON_INFO = "https://www.instagram.com/p/{{code}}/?__a=1";
  static const String MEDIA_JSON_BY_LOCATION_ID = "https://www.instagram.com/explore/locations/{{facebookLocationId}}/?__a=1&max_id={{maxId}}";
  static const String MEDIA_JSON_BY_TAG = "https://www.instagram.com/explore/tags/{{tag}}/?__a=1&max_id={{maxId}}";
  static const String GENERAL_SEARCH = "https://www.instagram.com/web/search/topsearch/?query={{query}}";
  static const String ACCOUNT_JSON_INFO_BY_ID = "https://www.instagram.com/graphql/query/?query_id=17880160963012870&id={{userId}}&first=1";
  static const String LAST_COMMENTS_BY_CODE = "ig_shortcode({{code}}){comments.last({{count}}){count,nodes{id,created_at,text,user{id,profile_pic_url,username,follows{count},followed_by{count},biography,full_name,media{count},is_private,external_url,is_verified}},page_info}}";
  static const String COMMENTS_BEFORE_COMMENT_ID_BY_CODE = "https://www.instagram.com/graphql/query/?query_id=17852405266163336&shortcode={{shortcode}}&first={{count}}&after={{commentId}}";
  static const String MEDIA_LIKE = "https://www.instagram.com/web/likes/{{mediaId}}/like/";
  static const String MEDIA_UNLIKE = "https://www.instagram.com/web/likes/{{mediaId}}/unlike/";
  static const String MEDIA_COMMENTS_ADD = "https://www.instagram.com/web/comments/{{mediaId}}/add/";
  static const String MEDIA_COMMENTS_DELETE = "https://www.instagram.com/web/comments/{{mediaId}}/delete/{{commentId}}/";
  static const String LIKES_BY_SHORTCODE = "https://www.instagram.com/graphql/query/?query_id=17864450716183058&variables={\"shortcode\":\"{{shortcode}}\",\"first\":{{count}},\"after\":\"{{after}}\"}";
  static const String FOLLOWS_URL = "https://www.instagram.com/graphql/query/?query_hash=37479f2b8209594dde7facb0d904896a&variables=%7B%22id%22%3A{{userId}}%2C%22first%22%3A{{count}}%2C%22after%22%3A%22{{endCursor}}%22%7D";
  static const String FOLLOWERS_URL = "https://www.instagram.com/graphql/query/?query_hash=37479f2b8209594dde7facb0d904896a&variables=%7B%22id%22%3A{{userId}}%2C%22first%22%3A{{count}}%2C%22after%22%3A%22{{endCursor}}%22%7D";
  static const String FOLLOW_ACCOUNT = "https://www.instagram.com/web/friendships/{{userId}}/follow/";
  static const String UNFOLLOW_ACCOUNT = "https://www.instagram.com/web/friendships/{{userId}}/unfollow/";
  static const String ACTIVITY_FEED = "https://www.instagram.com/accounts/activity/?__a=1";
  static const String ACTIVITY_MARK_CHECKED = "https://www.instagram.com/web/activity/mark_checked/";
  static const String SEARCH_USERS = "https://www.instagram.com/web/search/topsearch/?context=user&query={{username}}";
  static const String USERNAME = "{{username}}";
  static const String USER_ID = "{{userId}}";
  static const String MAX_ID = "{{maxId}}";
  static const String CODE = "{{code}}";
  static const String TAG_NAME = "{{tag_name}}";
  static const String COUNT = "{{count}}";
  static const String AFTER = "{{after}}";
  static const String SHORTCODE = "{{shortcode}}";
  static const String COMMENT_ID = "{{commentId}}";
  static const String MEDIA_ID = "{{mediaId}}";
  static const String END_CURSOR = "{{endCursor}}";
  static const String TAG = "{{tag}}";
  static const String QUERY = "{{query}}";
  static const String FACEBOOK_LOCATION_ID = "{{facebookLocationId}}";

  String getAccountId(String username) {
    return ACCOUNT_JSON_INFO.replaceAll(USERNAME, username);
  }

  String getAccountJsonInfoLinkByAccountId(int userId) {
    return ACCOUNT_JSON_INFO_BY_ID.replaceAll(USER_ID, "" + userId.toString());
  }

  String getSearchUserByUsername(String username) {
    return SEARCH_USERS.replaceAll(USERNAME, username);
  }

  String getAccountMediasJsonLink(int userId, String maxId) {
    if (maxId == null) {
      maxId = "";
    }
    return ACCOUNT_MEDIAS.replaceAll(USER_ID, userId.toString()).replaceAll(MAX_ID, maxId);
  }

  String getTagJsonByTagName(String tagName) {
    return TAG_JSON_INFO.replaceAll(TAG_NAME, tagName);
  }

  String getMediaPageLinkByCode(String code) {
    return MEDIA_LINK.replaceAll(CODE, code);
  }

  String getMediaPageLinkByCodeMatcher() {
    return MEDIA_LINK.replaceAll(CODE, "[\\w-_]+");
  }

  String getMediaJsonLinkByShortcode(String shortcode) {
    return MEDIA_JSON_INFO.replaceAll(CODE, shortcode);
  }

  String getMediasJsonByLocationIdLink(String facebookLocationId, String maxId) {
    if (maxId == null) {
      maxId = "";
    }
    return MEDIA_JSON_BY_LOCATION_ID.replaceAll(FACEBOOK_LOCATION_ID, facebookLocationId).replaceAll(MAX_ID, maxId);
  }

  String getMediasJsonByTagLink(String tag, String maxId) {
    if (maxId == null) {
      maxId = "";
    }
    return MEDIA_JSON_BY_TAG.replaceAll(TAG, tag).replaceAll(MAX_ID, maxId);
  }

  String getGeneralSearchJsonLink(String query) {
    return GENERAL_SEARCH.replaceAll(QUERY, query);
  }

  String getLastCommentsByCodeLink(String code, int count) {
    return LAST_COMMENTS_BY_CODE
        .replaceAll(CODE, code)
        .replaceAll(COUNT, count.toString());
  }

  String getCommentsBeforeCommentIdByCode(String shortcode, int count, String commentId) {
    return COMMENTS_BEFORE_COMMENT_ID_BY_CODE
        .replaceAll(SHORTCODE, shortcode)
        .replaceAll(COUNT, count.toString())
        .replaceAll(COMMENT_ID, commentId);
  }

  String getMediaLikeLink(String mediaId) {
    return MEDIA_LIKE.replaceAll(MEDIA_ID, mediaId);
  }

  String getMediaUnlikeLink(String mediaId) {
    return MEDIA_UNLIKE.replaceAll(MEDIA_ID, mediaId);
  }

  String addMediaCommentLink(String mediaId) {
    return MEDIA_COMMENTS_ADD.replaceAll(MEDIA_ID, mediaId);
  }

  String deleteMediaCommentLink(String mediaId, String commentId) {
    return MEDIA_COMMENTS_DELETE
        .replaceAll(MEDIA_ID, mediaId)
        .replaceAll(COMMENT_ID, commentId);
  }

  String getLikesByShortcode(String shortcode, int count, String endCursor){
    return LIKES_BY_SHORTCODE
        .replaceAll(SHORTCODE, shortcode)
        .replaceAll(COUNT, count.toString())
        .replaceAll(AFTER, endCursor);
  }

  String getFollowAccountLink(int userId) {
    return FOLLOW_ACCOUNT
        .replaceAll(USER_ID, userId.toString());
  }

  String getUnfollowAccountLink(int userId) {
    return UNFOLLOW_ACCOUNT
        .replaceAll(USER_ID, userId.toString());
  }

  String getFollowsLinkVariables(int userId, int count, String endCursor) {
    return FOLLOWS_URL
        .replaceAll(USER_ID, userId.toString())
        .replaceAll(COUNT, count.toString())
        .replaceAll(END_CURSOR, endCursor);
  }

  String getFollowersLinkVariables(int userId, int count, String endCursor) {
    return FOLLOWERS_URL
        .replaceAll(USER_ID, userId.toString())
        .replaceAll(COUNT, count.toString())
        .replaceAll(END_CURSOR, endCursor);
  }
}
