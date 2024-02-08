import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qc_entry/core/extension/text_extension.dart';
import 'package:qc_entry/core/injector/injector.dart';
import 'package:qc_entry/core/theme/app_color.dart';
import 'package:qc_entry/core/theme/app_text.dart';
import 'package:qc_entry/presentation/real_count/pilleg/provider/pilleg_provider.dart';
import 'package:qc_entry/presentation/real_count/shared/enumerator_notes.dart';
import 'package:qc_entry/presentation/real_count/shared/voice_text_field.dart';
import 'package:qc_entry/presentation/shared/custom_.dart';
import 'package:qc_entry/presentation/shared/custom_button.dart';
import 'package:qc_entry/presentation/shared/custom_dropdown.dart';
import 'package:qc_entry/presentation/survey/complete/screen/complete_page.dart';

class PillegPage extends StatelessWidget {
  const PillegPage({super.key});

  static const route = 'real-count/pilleg';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => getIt<PillegProvider>()
          ..getData().then((value) {
            if (value != null) {
              showQCEntrySnackBar(context: context, title: value);
            }
          }),
        child: const PartaiView());
  }
}

class PartaiView extends StatefulWidget {
  const PartaiView({super.key});

  @override
  State<PartaiView> createState() => _PartaiViewState();
}

class _PartaiViewState extends State<PartaiView> {
  late final TextEditingController dapilTextEditingController;
  late final TextEditingController kelurahanTextEditingController;
  late final TextEditingController partaiTextEditingController;
  late final TextEditingController jumlahDPTTextEditingController;
  @override
  void initState() {
    dapilTextEditingController = TextEditingController();
    kelurahanTextEditingController = TextEditingController();
    partaiTextEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    dapilTextEditingController.dispose();
    kelurahanTextEditingController.dispose();
    partaiTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pillegProvider = Provider.of<PillegProvider>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Pemilihan Legislatif"),
        ),
        body: pillegProvider.isLoading
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
                          pillegProvider.dapilList.length,
                          (index) => DropdownMenuEntry(
                              value: index,
                              label: pillegProvider.dapilList[index].index),
                        ),
                        label: "Dapil",
                        onSelected: (selectedItems) {
                          kelurahanTextEditingController.clear();
                          pillegProvider.setSelectedKelurahanIndex(null);
                          pillegProvider.setSelectedDapilIndex(selectedItems);
                        },
                      ),
                      const SizedBox(height: 12),
                      QCEntryDropdown(
                        textEditingController: kelurahanTextEditingController,
                        items: List.generate(
                            pillegProvider.selectedDapilIndex != null
                                ? pillegProvider
                                    .dapilList[
                                        pillegProvider.selectedDapilIndex!]
                                    .kelurahan
                                    .length
                                : 0,
                            (index) => DropdownMenuEntry(
                                value: index,
                                label: pillegProvider
                                    .dapilList[
                                        pillegProvider.selectedDapilIndex!]
                                    .kelurahan[index])),
                        label: "Kelurahan",
                        onSelected: (selectedItems) {
                          pillegProvider
                              .setSelectedKelurahanIndex(selectedItems);
                        },
                      ),
                      const SizedBox(height: 12),
                      QCEntryDropdown(
                        textEditingController: partaiTextEditingController,
                        items: List.generate(
                            pillegProvider.partaiList.length,
                            (index) => DropdownMenuEntry(
                                value: index,
                                label: pillegProvider.partaiList[index].nama)),
                        label: "Partai",
                        onSelected: (selectedItems) {
                          pillegProvider.setSelectedPartaiIndex(selectedItems);
                        },
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        onChanged: (value) => pillegProvider.setTPS(value),
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
                            pillegProvider.setJumlahDPT(value),
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
                        "Suara per Legislatif",
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
                                backgroundColor: AppColor.quaternaryColor,
                                child: Text(
                                  pillegProvider.calegList[index].noUrut,
                                  style: AppTextStyle.body2
                                      .setSemiBold()
                                      .copyWith(color: AppColor.primaryColor),
                                ),
                              ),
                            ),
                            label: pillegProvider.calegList[index].nama,
                            onChange: pillegProvider.changePresidentVoiceCount,
                            index: index),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemCount: pillegProvider.calegList.length,
                      ),
                      const Divider(),
                      VoiceTextField(
                        label: "Suara Tidak Sah",
                        onChangeNormal: pillegProvider.setUnsuccessfulVotes,
                      ),
                      const SizedBox(height: 24),
                      EnumeratorNotes(
                          onChange: pillegProvider.setEnumeratorNotes),
                      const SizedBox(height: 24),
                      QCEntryButton(
                        isLoading: pillegProvider.isSubmitLoading,
                        title: "Kirim",
                        onTap: () {
                          pillegProvider.submitPilleg().then((value) {
                            if (value != null) {
                              showQCEntrySnackBar(
                                  context: context, title: value);
                            } else {
                              Navigator.of(context).pushReplacementNamed(
                                  CompletePage.route,
                                  arguments: "quickcount");
                            }
                          });
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
