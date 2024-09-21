extension SearchWithCaseSensitive on List<String>{
  bool containsWithNoCaseSensitive(String text){
    for(String element in this){
      if(element.toLowerCase().contains(text.toLowerCase())){
        return true;
      }
    }

    return false;
  }
}