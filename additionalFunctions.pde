
/***
 * Teste si un élément est contenu dans un tableau
 * @param needle : l'élément à rechercher
 * @param haystack : la tableau
 * @return true si présent, sinon false
 */
public static boolean in_array(Object needle, Object[] haystack) {
  return (Arrays.binarySearch(haystack, needle) >= 0);
}


/***
 * Fusionne les éléments d'un tableau en une chaîne
 * @param delim : la chaîne de séparation
 * @param args : la tableau
 * @return la chaîne fusionnée
 */
public static String implode(String delim, String[] args) {
  StringBuffer sb = new StringBuffer();
  for (int i =0; i < args.length; i++) {
    if (i > 0) {
      sb.append(delim);
    }
    sb.append(args[i]);
  }
  return sb.toString();
}

