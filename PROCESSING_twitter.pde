// télécharger http://twitter4j.org/en/index.html
// http://codasign.com/tutorials/processing-and-twitter-searching-twitter-for-tweets/

// exemple également ici : http://codelab.fr/4331

// modifié par Loïc Horellou
// afin de charger des préférences en json

// Il faut obligatoirement avoir un compte twitter
// Ensuite aller sur https://dev.twitter.com
// se connecter
// aller sur https://apps.twitter.com
// créer une nouvelle application (attention à ne pas utiliser « twitter » dans le nom
// aller dans API Keys
// Cliquer sur Create my access token
import twitter4j.conf.*;
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import java.util.*;


processing.data.JSONObject param;

Twitter twitter;
String searchString = "loichorellou";
List<Status> tweets;

int currentTweet;


void setup() {
  size(800, 600);
  background(0);

  param = loadJSONObject("data/param.json");

  String ConsumerKey       = param.getString("ConsumerKey");
  String ConsumerSecret    = param.getString("ConsumerSecret");
  String AccessToken       = param.getString("AccessToken");
  String AccessTokenSecret = param.getString("AccessTokenSecret");

  ConfigurationBuilder cb = new ConfigurationBuilder();
  cb.setOAuthConsumerKey(ConsumerKey);
  cb.setOAuthConsumerSecret(ConsumerSecret);
  cb.setOAuthAccessToken(AccessToken);
  cb.setOAuthAccessTokenSecret(AccessTokenSecret);

  TwitterFactory tf = new TwitterFactory(cb.build());

  twitter = tf.getInstance();

  getNewTweets();

  currentTweet = 0;

  thread("refreshTweets");
}

void draw() {
  //background(0);
  fill(0, 5);
  noStroke();
  rect(0, 0, width, height);

  currentTweet = currentTweet + 1;

  if (currentTweet >= tweets.size()) {
    currentTweet = 0;
  }

  Status status = tweets.get(currentTweet);

  fill(200);
  text(status.getText(), random(width), random(height), 300, 200);

  delay(30);
}

void getNewTweets() {
  try {
    Query query = new Query(searchString);

    QueryResult result = twitter.search(query);

    tweets = result.getTweets();
  } 
  catch (TwitterException te) {
    System.out.println("Failed to search tweets: " + te.getMessage());
    System.exit(-1);
  }
}

void refreshTweets() {
  while (true) {
    getNewTweets();

    println("Updated Tweets"); 

    delay(30000);
  }
}

