enum MatterState { solid, liquid, gas }

extension MatterStateContent on MatterState {
  String get label {
    switch (this) {
      case MatterState.solid:
        return 'Padat';
      case MatterState.liquid:
        return 'Cair';
      case MatterState.gas:
        return 'Gas';
    }
  }

  String get description {
    switch (this) {
      case MatterState.solid:
        return 'Partikel tersusun sangat rapat dan hanya bergetar di sekitar posisinya.';
      case MatterState.liquid:
        return 'Partikel tetap berdekatan, tetapi dapat bergerak dan bergeser satu sama lain.';
      case MatterState.gas:
        return 'Partikel berjauhan dan bergerak bebas dengan kecepatan yang lebih tinggi.';
    }
  }

  String get particleBehavior {
    switch (this) {
      case MatterState.solid:
        return 'Rapat dan teratur';
      case MatterState.liquid:
        return 'Dekat dan bergerak';
      case MatterState.gas:
        return 'Renggang dan bebas';
    }
  }
}
