class Compartir{

  String _parroquia;

  //Constructor
  Compartir(this._parroquia);

  //Setter
  set parroquia(String parroquia){
    this._parroquia=parroquia;
  }
  //Getter
  String get parroquia => this._parroquia;
}