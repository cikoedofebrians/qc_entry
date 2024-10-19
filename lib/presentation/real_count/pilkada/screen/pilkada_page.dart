import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qc_entry/core/errors/error_handler.dart';
import 'package:qc_entry/core/extension/text_extension.dart';
import 'package:qc_entry/core/injector/injector.dart';
import 'package:qc_entry/core/theme/app_color.dart';
import 'package:qc_entry/core/theme/app_text.dart';
import 'package:qc_entry/presentation/real_count/pilkada/provider/pilkada_provider.dart';
import 'package:qc_entry/presentation/real_count/shared/enumerator_notes.dart';
import 'package:qc_entry/presentation/real_count/shared/voice_text_field.dart';
import 'package:qc_entry/presentation/shared/custom_snackbar.dart';
import 'package:qc_entry/presentation/shared/custom_button.dart';
import 'package:qc_entry/presentation/shared/custom_dropdown.dart';
import 'package:qc_entry/presentation/survey/complete/screen/complete_page.dart';

class PilkadaPage extends StatelessWidget {
  const PilkadaPage({super.key});

  static const route = 'real-count/pilkada';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => getIt<PilkadaProvider>()
        ..getData().then(
          (value) => errorHandler(value, context, true),
        ),
      child: const PilkadaView(),
    );
  }
}

class PilkadaView extends StatefulWidget {
  const PilkadaView({super.key});

  @override
  State<PilkadaView> createState() => _PilpresViewState();
}

class _PilpresViewState extends State<PilkadaView> {
  late final TextEditingController dapilTextEditingController;
  late final TextEditingController kelurahanTextEditingController;

  @override
  void initState() {
    dapilTextEditingController = TextEditingController();
    kelurahanTextEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    dapilTextEditingController.dispose();
    kelurahanTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pilkadaProvider = Provider.of<PilkadaProvider>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Pemilihan Kepala Daerah"),
        ),
        body: pilkadaProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      QCEntryDropdown(
                        textEditingController: dapilTextEditingController,
                        items: List.generate(
                          pilkadaProvider.dapilList.length,
                          (index) => DropdownMenuEntry(
                              value: index,
                              label: pilkadaProvider.dapilList[index].index),
                        ),
                        label: "Dapil",
                        onSelected: (selectedItems) {
                          kelurahanTextEditingController.clear();
                          pilkadaProvider.setSelectedKelurahanIndex(null);
                          pilkadaProvider.setSelectedDapilIndex(selectedItems);
                        },
                      ),
                      const SizedBox(height: 12),
                      QCEntryDropdown(
                        textEditingController: kelurahanTextEditingController,
                        items: List.generate(
                            pilkadaProvider.selectedDapilIndex != null
                                ? pilkadaProvider
                                    .dapilList[
                                        pilkadaProvider.selectedDapilIndex!]
                                    .kelurahan
                                    .length
                                : 0,
                            (index) => DropdownMenuEntry(
                                value: index,
                                label: pilkadaProvider
                                    .dapilList[
                                        pilkadaProvider.selectedDapilIndex!]
                                    .kelurahan[index])),
                        label: "Kelurahan",
                        onSelected: (selectedItems) {
                          pilkadaProvider
                              .setSelectedKelurahanIndex(selectedItems);
                        },
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        onChanged: (value) => pilkadaProvider.setTPS(value),
                        decoration: InputDecoration(
                            label: Text(
                              "TPS",
                              style: AppTextStyle.body3
                                  .setSemiBold()
                                  .copyWith(color: AppColor.primaryColor),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        onChanged: (value) =>
                            pilkadaProvider.setJumlahDPT(value),
                        decoration: InputDecoration(
                            label: Text(
                              "Jumlah DPT",
                              style: AppTextStyle.body3
                                  .setSemiBold()
                                  .copyWith(color: AppColor.primaryColor),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        "Suara Calon Kepala Daerah",
                        style: AppTextStyle.heading5
                            .setSemiBold()
                            .copyWith(color: AppColor.secondaryColor),
                      ),
                      const SizedBox(height: 20),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => VoiceTextField(
                            leading: Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor: AppColor.secondaryColor,
                                child: Text(
                                  pilkadaProvider
                                      .cakadaList[index].noUrutPaslon,
                                  style: AppTextStyle.body2
                                      .setSemiBold()
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                            label: pilkadaProvider.cakadaList[index].namaPaslon,
                            onChange: pilkadaProvider.changeCakadaVoiceCount,
                            index: index),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemCount: pilkadaProvider.cakadaList.length,
                      ),
                      const Divider(),
                      VoiceTextField(
                        label: "Suara Tidak Sah",
                        onChangeNormal: pilkadaProvider.setUnsuccessfulVotes,
                      ),
                      const SizedBox(height: 24),
                      EnumeratorNotes(
                          onChange: pilkadaProvider.setEnumeratorNotes),
                      const SizedBox(height: 24),
                      QCEntryButton(
                        color: AppColor.tertiaryColor,
                        isLoading: pilkadaProvider.isSubmitLoading,
                        title: "Kirim",
                        onTap: () {
                          if (!pilkadaProvider.isSubmitLoading) {
                            pilkadaProvider.cubmitPilpres().then((value) {
                              if (value != null) {
                                showQCEntrySnackBar(
                                    context: context, title: value);
                              } else {
                                Navigator.of(context).pushReplacementNamed(
                                    CompletePage.route,
                                    arguments: "quickcount");
                              }
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
