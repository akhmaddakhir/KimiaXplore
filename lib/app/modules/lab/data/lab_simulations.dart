import '../models/simulation_model.dart';

abstract final class LabSimulations {
  static const List<SimulationModel> items = [
    SimulationModel(
      id: 'periodic_table',
      title: 'Tabel Periodik',
      description: 'Jelajahi unsur kimia dan kenali sifat-sifatnya.',
    ),
    SimulationModel(
      id: 'electron_configuration',
      title: 'Konfigurasi Elektron',
      description: 'Pelajari susunan elektron di dalam atom.',
    ),
    SimulationModel(
      id: 'states_of_matter',
      title: 'Wujud Zat',
      description: 'Amati perubahan wujud zat dan gerakan partikelnya.',
    ),
    SimulationModel(
      id: 'ph_meter',
      title: 'pH Meter',
      description: 'Uji tingkat keasaman dan kebasaan berbagai larutan.',
    ),
    SimulationModel(
      id: 'reaction_balancer',
      title: 'Penyeimbang Reaksi',
      description: 'Latih kemampuan menyetarakan persamaan reaksi kimia.',
    ),
    SimulationModel(
      id: 'titration',
      title: 'Titrasi',
      description: 'Eksplorasi reaksi asam dan basa melalui titrasi.',
    ),
  ];
}
