import 'package:flutter/material.dart';
import 'package:qc_entry/core/errors/failure.dart';
import 'package:qc_entry/data/model/realcount/caleg/caleg_model.dart';
import 'package:qc_entry/data/model/realcount/dapil/dapil_model.dart';
import 'package:qc_entry/data/model/realcount/partai/partai_model.dart';
import 'package:qc_entry/data/repository/raelcount_repository.dart';

class PillegProvider extends ChangeNotifier {
  PillegProvider(this.realcountRepository);
  final RealcountRepository realcountRepository;

  List<Partai> partaiList = [];
  bool isLoading = false;
  List<Dapil> dapilList = [];
  int? selectedDapilIndex;
  int? selectedKelurahanIndex;
  int? selectedPartaiIndex;
  String tps = "";
  String enumeratorNotes = "";
  String jumlahDPT = "";

  setJumlahDPT(String newJumlahDPT) {
    jumlahDPT = newJumlahDPT;
  }

  bool isSubmitLoading = false;
  bool isFetchLoading = false;

  setSubmitLoading(bool newValue) {
    isSubmitLoading = newValue;
    notifyListeners();
  }

  List<Caleg> calegList = [];

  Future<Failure?> getData() async {
    isLoading = true;
    notifyListeners();
    final dapilResult = await getAllDapil();
    if (dapilResult != null) {
      isLoading = false;
      notifyListeners();
      return dapilResult;
    }
    final capresResult = await getAllPartai();
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

  Future<Failure?> getAllPartai() async {
    Failure? failure;
    final result = await realcountRepository.getAllPartai();
    result.fold((l) {
      failure = l;
    }, (r) {
      partaiList = r;
      notifyListeners();
    });
    return failure;
  }

  setSelectedPartaiIndex(int newIndex) {
    selectedPartaiIndex = newIndex;
    notifyListeners();
    if (selectedDapilIndex != null && selectedKelurahanIndex != null) {
      getAllCaleg();
    }
  }

  changePresidentVoiceCount(int index, String newVoice) {
    final newCaleg = calegList[index].copyWith(suara: newVoice);
    calegList[index] = newCaleg;
    notifyListeners();
  }

  setTPS(String newTPS) {
    tps = newTPS;
  }

  setSelectedDapilIndex(int? newIndex) {
    selectedDapilIndex = newIndex;
    setCalegList([]);
    notifyListeners();
  }

  setSelectedKelurahanIndex(int? newIndex) {
    selectedKelurahanIndex = newIndex;
    if (selectedPartaiIndex != null && newIndex != null) {
      getAllCaleg();
    }
  }

  setEnumeratorNotes(String newNotes) {
    enumeratorNotes = newNotes;
  }

  setCalegList(List<Caleg> newCalegList) {
    calegList = newCalegList;

    notifyListeners();
  }

  getAllCaleg() async {
    isFetchLoading = true;
    notifyListeners();
    final result = await realcountRepository.getAllCaleg(
        partaiId: partaiList[selectedPartaiIndex!].id,
        dapilId: dapilList[selectedDapilIndex!].id);
    result.fold((l) {
      isFetchLoading = false;
      notifyListeners();
    }, (r) {
      isFetchLoading = false;
      setCalegList(r);
    });
  }

  Future<String?> submitPilleg() async {
    if (selectedDapilIndex == null) return "Dapil tidak boleh kosong";
    if (selectedKelurahanIndex == null) return "Kelurahan tidak boleh kosong";
    if (selectedPartaiIndex == null) return "Partai tidak boleh kosong";
    if (jumlahDPT.isEmpty) return "Jumlah DPT tidak boleh kosong";

    if (tps.isEmpty) return "TPS tidak boleh kosong";
    for (var caleg in calegList) {
      if (caleg.suara.isEmpty) {
        return "Suara calon legislatif tidak boleh ada yang kosong";
      }
    }
    if (enumeratorNotes.isEmpty) {
      return "Catatan enumerator tidak boleh kosong";
    }
    final List<Map<String, int>> hasilSuaraSah = calegList
        .map(
          (e) => {
            'caleg_id': e.id,
            'jumlah_suara': int.parse(e.suara),
          },
        )
        .toList();

    setSubmitLoading(true);
    final result = await realcountRepository.submitPilleg(
      dapilId: dapilList[selectedDapilIndex!].id,
      kelurahan:
          dapilList[selectedDapilIndex!].kelurahan[selectedKelurahanIndex!],
      tps: tps,
      hasilSuaraSah: hasilSuaraSah,
      notes: enumeratorNotes,
      jumlahDPT: int.parse(jumlahDPT),
    );
    setSubmitLoading(false);
    String? isError;

    result.fold((l) => isError = l.message, (r) => null);
    return isError;
  }
}
