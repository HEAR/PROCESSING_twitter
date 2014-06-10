// http://docs.oracle.com/javase/6/docs/api/java/util/Date.html

String dateFormat(java.util.Date laDate){ 
  Calendar cal = Calendar.getInstance();
  cal.setTime(laDate);
  
  int annee      = cal.get(Calendar.YEAR) ;
  String mois    = "00"+cal.get(Calendar.MONTH);
  String jour    = "00"+cal.get(Calendar.DAY_OF_MONTH);
  
  mois  = mois.substring(mois.length()-2);
  jour  = jour.substring(jour.length()-2);
  
  return jour+"/"+mois+"/"+annee;
}

String heureFormat(java.util.Date laDate){  
  Calendar cal = Calendar.getInstance();
  cal.setTime(laDate);  
  
  String heures  = "00"+cal.get(Calendar.HOUR_OF_DAY);
  String minutes = "00"+cal.get(Calendar.MINUTE);
  
  heures  = heures.substring(heures.length()-2);
  minutes = minutes.substring(minutes.length()-2);
  
  return heures+"H"+minutes;
}

String horodateur(){
   String timestamp, mois, jour, heure, minute, seconde;
  
  
  mois = "00"+month();
  mois = mois.substring(mois.length()-2);
  
  jour = "00"+day();
  jour = jour.substring(jour.length()-2);
  
  heure = "00"+hour();
  heure = heure.substring(heure.length()-2);
  
  minute = "00"+minute();
  minute = minute.substring(minute.length()-2);
  
  seconde = "00"+second();
  seconde = seconde.substring(seconde.length()-2);
 
  timestamp = year()+mois+jour+"-"+heure+minute+seconde;
  
 //year()+month()+day()+"-"+hour()+minute()+second();
  return timestamp;
}
