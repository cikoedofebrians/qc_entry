import 'package:flutter/material.dart';
import 'package:qc_entry/data/model/realcount/dapil/dapil_model.dart';
import 'package:qc_entry/data/model/realcount/partai/partai_model.dart';
import 'package:qc_entry/data/repository/raelcount_repository.dart';

class PartaiProvider extends ChangeNotifier {
  PartaiProvider(this.realcountRepository);
  final RealcountRepository realcountRepository;
  List<Partai> partaiList = [];

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

  Future<String?> getData() async {
    isLoading = true;
    notifyListeners();
    final dapilResult = await getAllDapil();
    if (dapilResult != null) return dapilResult;
    final capresResult = await getAllPartai();
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

  Future<String?> getAllPartai() async {
    String? errorMessage;
    final result = await realcountRepository.getAllPartai();
    result.fold((l) {
      errorMessage = l.message;
    }, (r) {
      partaiList = r;
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
    final newPartai = partaiList[index].copyWith(suara: newVoice);
    partaiList[index] = newPartai;
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

  Future<String?> submitPartai() async {
    if (selectedDapilIndex == null) return "Dapil tidak boleh kosong";
    if (selectedKelurahanIndex == null) return "Kelurahan tidak boleh kosong";
    if (tps.isEmpty) return "TPS tidak boleh kosong";
    if (jumlahDPT.isEmpty) return "Jumlah DPT tidak boleh kosong";

    for (var partai in partaiList) {
      if (partai.suara.isEmpty) {
        return "Suara partai tidak boleh ada yang kosong";
      }
    }
    if (unsuccessfulVotes.isEmpty) {
      return "Suara partai tidak boleh ada yang kosong";
    }
    if (enumeratorNotes.isEmpty) {
      return "Catatan enumerator tidak boleh kosong";
    }
    final List<Map<String, int>> hasilSuaraSah = partaiList
        .map(
          (e) => {
            'partai_id': e.id,
            'jumlah_suara': int.parse(e.suara),
          },
        )
        .toList();
    setSubmitLoading(true);
    final result = await realcountRepository.submitPilpar(
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
