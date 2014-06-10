// fonction d'affichage des tweets

void showTweet(Status status, int i) {

  // http://twitter4j.org/javadoc/twitter4j/Status.html
  // http://twitter4j.org/javadoc/twitter4j/User.html

  println("nouveau tweet");
  println(status.getId()); // id du tweet
  String auteur = status.getUser().getName().toUpperCase();
  String login  = status.getUser().getScreenName();
  String lieu   = status.getUser().getLocation().toUpperCase();
  String description = status.getUser().getDescription();
  String message = status.getText();
  println(dateFormat(status.getCreatedAt() )+ " " +heureFormat(status.getCreatedAt() ));
  println("-----------------");


  // valeur de décalage vertical pour chaque tweet
  float baseY = i*(hauteur+marginTop+marginBottom);

  strokeWeight(1);
  if (i!=0) {
    line(marginLeft, baseY, width-marginRight, baseY);
  }

  // avatar
  String avatarURL = status.getUser().getOriginalProfileImageURL();
  try {
    PImage avatar = loadImage(avatarURL);
    avatar = crop(avatar, avatarW, avatarH);
    image(avatar, marginLeft, baseY+marginTop);
  }
  finally {
  }
  noFill();
  rect(marginLeft, baseY+marginTop, avatarW, avatarH);

  textSize(12);
  fill(0);

  String meta[] = new String[3];
  meta[0] = "Auteur : "+auteur+"<br/>";
  meta[1] = "@"+login+"<br/>";
  meta[2] = "Lieu : "+lieu+"<br/>";

  try {
    RiText.defaultFont("Helvetica", 10);
    metaRT = RiText.createLines(this, meta, xMeta, baseY+yMeta, wMeta);
  } 
  finally {
    // nothing
  }

  try {
    RiText.defaultFont("Helvetica", 9);
    descriptionRT = RiText.createWords(this, description, xDesc, baseY+yDesc, wDesc, hDesc);

    if (showGrid) {
      noFill();
      rect(xDesc, baseY+yDesc, wDesc, hDesc);
    }
  } 
  finally {
    // nothing
  }

  try {
    RiText.defaultFont("Helvetica", 25);
    messageRT = RiText.createWords(this, message, xMess, baseY+yMess, wMess, hMess);
    if (showGrid) {
      noFill();
      rect(xMess, baseY+yMess, wMess, hMess);
    }

    // on verifie si les mots cherchés sont présents dans le texte
    for (int j = 0; j < messageRT.length; j++) {
      String lemot = messageRT[j].toLowerCase().text();
      Boolean motTrouve = false;
      for (int ii = 0; ii<mots.length; ii++) {
        String check =  mots[ii].toLowerCase();
        if (lemot.indexOf(check) != -1 ) {
          println(check+" "+lemot);
          motTrouve = true;
        }
      }

      if (motTrouve) {
        messageRT[j].fill(255);
        println("+--------------> mot trouvé");
        float coord[] = messageRT[j].boundingBox();
        fill(0);
        rect(coord[0]-3, coord[1]-5, coord[2]+3, coord[3]+3);

        float X = coord[0]+coord[2]/2;
        float Y = coord[1]+coord[3]/2;

        if (firstLine) {
          strokeWeight(5);
          line(X, Y, oldX, oldY);
        }

        firstLine = true;
        oldX = X;
        oldY = Y;
      }
    }
  }
  catch(ArrayIndexOutOfBoundsException e) {
    println("erreur… on continue");
  }
}

