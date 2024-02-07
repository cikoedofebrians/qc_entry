import 'package:flutter/material.dart';
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

  List<Capres> capresList = [];

  Future<String?> getData() async {
    isLoading = true;
    notifyListeners();
    final dapilResult = await getAllDapil();
    if (dapilResult != null) return dapilResult;
    final capresResult = await getAllCapres();
    isLoading = false;
    notifyListeners();
    return capresResult;
  }

  Future<String?> getAllDapil() async {
    String? errorMessage;
    final result = await realcountRepository.getAllDapil();
    result.fold((l) {
      errorMessage = l.message;
    }, (r) {
      dapilList = r;
      notifyListeners();
    });
    return errorMessage;
  }

  Future<String?> getAllCapres() async {
    String? errorMessage;
    final result = await realcountRepository.getAllCapres();
    result.fold((l) {
      errorMessage = l.message;
    }, (r) {
      capresList = r;
      notifyListeners();
    });
    return errorMessage;
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
        return "Suara presiden tidak boleh ada yang kosong";
      }
    }
    if (unsuccessfulVotes.isEmpty) {
      return "Suara presiden tidak boleh ada yang kosong";
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
    String? isError;

    result.fold((l) => isError = l.message, (r) => null);
    return isError;
  }
}
