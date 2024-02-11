import 'package:flutter/material.dart';
import 'package:qc_entry/core/errors/failure.dart';
import 'package:qc_entry/data/model/realcount/capres/capres_model.dart';
import 'package:qc_entry/data/model/realcount/dapil/dapil_model.dart';
import 'package:qc_entry/data/repository/raelcount_repository.dart';

class PilpresProvider extends ChangeNotifier {
  final RealcountRepository realcountRepository;
  PilpresProvider(this.realcountRepository);

  bool isLoading = false;
  List<Dapil> dapilList = [];
  int? selectedDapilIndex;
  int? selectedKelurahanIndex;
  String unsuccessfulVotes = "";
  String tps = "";
  String enumeratorNotes = "";
  String jumlahDPT = "";

  setJumlahDPT(String newJumlahDPT) {
    jumlahDPT = newJumlahDPT;
  }

  bool isSubmitLoading = false;

  setSubmitLoading(bool newValue) {
    isSubmitLoading = newValue;
    notifyListeners();
  }

  List<Capres> capresList = [];

  Future<Failure?> getData() async {
    isLoading = true;
    notifyListeners();
    final dapilResult = await getAllDapil();
    if (dapilResult != null) {
      isLoading = false;
      notifyListeners();
      return dapilResult;
    }
    final capresResult = await getAllCapres();
    isLoading = false;
    notifyListeners();
    return capresResult;
  }

  Future<Failure?> getAllDapil() async {
    Failure? failure;
    final result = await realcountRepository.getAllDapil();
    result.fold((l) {
      failure = l;
    }, (r) {
      dapilList = r;
      notifyListeners();
    });
    return failure;
  }

  Future<Failure?> getAllCapres() async {
    Failure? failure;
    final result = await realcountRepository.getAllCapres();
    result.fold((l) {
      failure = l;
    }, (r) {
      capresList = r;
      notifyListeners();
    });
    return failure;
  }

  setTPS(String newTPS) {
    tps = newTPS;
  }

  setUnsuccessfulVotes(String newVotes) {
    unsuccessfulVotes = newVotes;
  }

  changePresidentVoiceCount(int index, String newVoice) {
    final newCapres = capresList[index].copyWith(suara: newVoice);
    capresList[index] = newCapres;
    notifyListeners();
  }

  setSelectedDapilIndex(int? newIndex) {
    selectedDapilIndex = newIndex;
    notifyListeners();
  }

  setSelectedKelurahanIndex(int? newIndex) {
    selectedKelurahanIndex = newIndex;
  }

  setEnumeratorNotes(String newNotes) {
    enumeratorNotes = newNotes;
  }

  Future<String?> cubmitPilpres() async {
    if (selectedDapilIndex == null) return "Dapil tidak boleh kosong";
    if (selectedKelurahanIndex == null) return "Kelurahan tidak boleh kosong";
    if (tps.isEmpty) return "TPS tidak boleh kosong";
    if (jumlahDPT.isEmpty) return "Jumlah DPT tidak boleh kosong";

    for (var capres in capresList) {
      if (capres.suara.isEmpty) {
        return "Suara calon presiden tidak boleh ada yang kosong";
      }
    }
    if (unsuccessfulVotes.isEmpty) {
      return "Suara calon presiden tidak boleh ada yang kosong";
    }
    if (enumeratorNotes.isEmpty) {
      return "Catatan enumerator tidak boleh kosong";
    }
    final List<Map<String, int>> hasilSuaraSah = capresList
        .map(
          (e) => {
            'capres_id': e.id,
            'jumlah_suara': int.parse(e.suara),
          },
        )
        .toList();
    setSubmitLoading(true);
    final result = await realcountRepository.submitCapres(
      dapilId: dapilList[selectedDapilIndex!].id,
      kelurahan:
          dapilList[selectedDapilIndex!].kelurahan[selectedKelurahanIndex!],
      tps: tps,
      hasilSuaraSah: hasilSuaraSah,
      hasilSuaraTidakSah: int.parse(unsuccessfulVotes),
      notes: enumeratorNotes,
      jumlahDPT: int.parse(jumlahDPT),
    );
    setSubmitLoading(false);
    String? isError;

    result.fold((l) => isError = l.message, (r) => null);
    return isError;
  }
}
