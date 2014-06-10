/** 
 * FONCTION POUR CROPPER UNE IMAGE
 */
PImage crop(PImage source, int largeur, int hauteur) {

  // on recupere les dimensions de l'image source
  int oW = source.width;
  int oH = source.height;

  // on stocke les nouvelles dimensions
  int nW = largeur;
  int nH = hauteur;

  // on stocke les 2 ratios pour déterminer le sens du recadrage
  float oRatio = oW/oH;
  float nRatio = nW/nH;

  // on compare les ratios pour 
  // 1 - redimentionner
  // 2 - recadrer
  if (oRatio < nRatio) {
    source.resize(nW, int(nH*oRatio));
    source = source.get(0, int( (source.height-nH)/2 ), nW, nH);
  } else {
    source.resize(int(nW*oRatio), nH);
    source = source.get( int( (source.width-nW) /2 ), 0, nW, nH);
  }

  // on renvoie l'image générée
  return source;
}

