import 'package:flutter/material.dart';
import 'package:qc_entry/core/errors/failure.dart';
import 'package:qc_entry/data/model/realcount/cakada/cakada_model.dart';
import 'package:qc_entry/data/model/realcount/dapil/dapil_model.dart';
import 'package:qc_entry/data/repository/raelcount_repository.dart';

class PilkadaProvider extends ChangeNotifier {
  final RealcountRepository realcountRepository;
  PilkadaProvider(this.realcountRepository);

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

  List<Cakada> cakadaList = [];

  Future<Failure?> getData() async {
    isLoading = true;
    notifyListeners();
    final dapilResult = await getAllDapil();
    if (dapilResult != null) {
      isLoading = false;
      notifyListeners();
      return dapilResult;
    }
    final capresResult = await getAllCakada();
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

  Future<Failure?> getAllCakada() async {
    Failure? failure;
    final result = await realcountRepository.getAllCakada();
    result.fold((l) {
      failure = l;
    }, (r) {
      cakadaList = r;
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

  changeCakadaVoiceCount(int index, String newVoice) {
    final newCapres = cakadaList[index].copyWith(suara: newVoice);
    cakadaList[index] = newCapres;
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

    for (var cakada in cakadaList) {
      if (cakada.suara.isEmpty) {
        return "Suara calon pilkada tidak boleh ada yang kosong";
      }
    }
    if (unsuccessfulVotes.isEmpty) {
      return "Suara yang tidak sah tidak boleh kosong";
    }
    if (enumeratorNotes.isEmpty) {
      return "Catatan enumerator tidak boleh kosong";
    }
    try {
      final List<Map<String, int>> hasilSuaraSah = cakadaList
          .map(
            (e) => {
              'cakada_id': e.id,
              'jumlah_suara': int.parse(e.suara),
            },
          )
          .toList();
      setSubmitLoading(true);
      final result = await realcountRepository.submitPilkada(
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
    } catch (e) {
      return "Terjadi kesalahan. Pastikan semua isian anda memiliki format data yang benar.";
    }
  }
}
