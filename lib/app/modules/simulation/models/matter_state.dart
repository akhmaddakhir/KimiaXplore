import 'package:get/get.dart';

enum MatterState { solid, liquid, gas }

extension MatterStateContent on MatterState {
  String get label {
    switch (this) {
      case MatterState.solid:
        return 'matter_solid'.tr;
      case MatterState.liquid:
        return 'matter_liquid'.tr;
      case MatterState.gas:
        return 'matter_gas'.tr;
    }
  }

  String get description {
    switch (this) {
      case MatterState.solid:
        return 'matter_solid_desc'.tr;
      case MatterState.liquid:
        return 'matter_liquid_desc'.tr;
      case MatterState.gas:
        return 'matter_gas_desc'.tr;
    }
  }

  String get particleBehavior {
    switch (this) {
      case MatterState.solid:
        return 'matter_solid_behavior'.tr;
      case MatterState.liquid:
        return 'matter_liquid_behavior'.tr;
      case MatterState.gas:
        return 'matter_gas_behavior'.tr;
    }
  }
}
