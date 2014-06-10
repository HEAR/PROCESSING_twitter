/**
 * THIBAUT SAVIGNAC
 * HEAR.FR - Communication graphique
 *
 * ---------------------------------
 *      !!  IMPORTANT  !!
 * ---------------------------------
 *
 * télécharger les librairies suivantes :
 * http://twitter4j.org/en/index.html
 * http://rednoise.org/rita/download/index.html [RiTa library (java, js, reference, examples, tutorial, src)]
 */

// http://codasign.com/tutorials/processing-and-twitter-searching-twitter-for-tweets/
// http://stackoverflow.com/questions/17261607/twitter-api-1-1-using-twitter4j
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
// dupliquer le fichier param-sample.json, le renommer param.json et ajouter les paramètres de twitter

import processing.pdf.*;

import twitter4j.conf.*;
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import java.util.*;
import rita.*;


processing.data.JSONObject param;
processing.data.JSONObject userJSON;

Twitter twitter;
String searchString;
List<Status> tweets;

int currentTweet;


String mots[] = {
  "Privacy",  "Computer_Terrorism", "Firewalls", "Passwords", "Hackers", "Encryption", "Echelon", "Dictionary", "Police", "sniper", "High_Security", "Counterterrorism", "spies", "eavesdropping", "interception", "ninja", "Merlin", "Porno", "white_noise", "top_secret","Macintosh_Security" , "Macintosh_Firewalls", "VIP_Protection", "Coderpunks", "redheads", "Nuclear", "subversives", "data_havens", "Elvis", "World_Domination", "AT&T", "Satellite_phones", "Sears_Tower", "rebels"
};

// DIMENSIONS DES BOITES
RiText descriptionRT[], messageRT[], metaRT[];
float oldX, oldY;
boolean firstLine, showGrid;

int marginTop    ;
int marginBottom ;
int marginLeft   ;
int marginRight  ;

int marginIntern ;

int hauteur ;
int statutW ;

int avatarW ;
int avatarH ;

int xMeta ;
int yMeta ;
int wMeta ;
int hMeta;

int xDesc ;
int yDesc ;
int wDesc ;
int hDesc;

int xMess ;
int yMess ;
int wMess ;
int hMess ;
// FIN DES DIMENSIONS


void setup() {
  size(700, 1000, PDF, "export/tweets-"+horodateur()+".pdf");
  //size(700, 1000);

  // on crée la chaine de mots que l'on va chercher dans twitter
  searchString = implode(" OR ", mots);

  // CALCUL DES BOITES DE TWEETS
  firstLine = false;
  showGrid = false;

  marginTop    = 30;
  marginBottom = 40;
  marginLeft   = 30;
  marginRight  = 30;

  marginIntern = 15;

  hauteur = 120;
  statutW = 150;

  avatarW = 80;
  avatarH = 110;

  xMeta = marginLeft+avatarW+marginIntern;
  yMeta = marginTop;
  wMeta = statutW;

  xDesc = marginLeft+avatarW+marginIntern;
  yDesc = marginTop+36+marginIntern;
  wDesc = statutW;
  hDesc = hauteur-yDesc+marginTop;
  println(hDesc);

  xMess = xMeta+wMeta+marginIntern;
  yMess = marginTop;
  wMess = width-(xMeta+wMeta+marginIntern+marginLeft);
  hMess = hauteur;
  // FIN DU CALCUL

  background(255);
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

  currentTweet = 0;

  //thread("refreshTweets");
}

void draw() {
  getNewTweets();
}

void getNewTweets() {
  try {
    Query query = new Query(searchString);
    query.setCount(5);
    QueryResult result = twitter.search(query);

    //tweets = result.getTweets();

    //beginRecord(PDF, "export/tweets-" + frameCount + ".pdf");

    int i = 0;
    for (Status status : result.getTweets ()) {
      showTweet(status, i);
      i++;
    }

    RiText.drawAll();

    println("FIN DE PDF");
  } 
  catch (TwitterException te) {
    System.out.println("Failed to search tweets: " + te.getMessage());
    System.exit(-1);
  }
  RiText.disposeAll();
  delay(10000);
  exit();
}


void refreshTweets() {
  while (true) {
    getNewTweets();

    println("Updated Tweets");

    delay(300000);
  }
}

