import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qc_entry/core/extension/text_extension.dart';
import 'package:qc_entry/core/injector/injector.dart';
import 'package:qc_entry/core/theme/app_color.dart';
import 'package:qc_entry/core/theme/app_text.dart';
import 'package:qc_entry/presentation/real_count/partai/provider/partai_provider.dart';
import 'package:qc_entry/presentation/real_count/shared/enumerator_notes.dart';
import 'package:qc_entry/presentation/real_count/shared/voice_text_field.dart';
import 'package:qc_entry/presentation/shared/custom_.dart';
import 'package:qc_entry/presentation/shared/custom_button.dart';
import 'package:qc_entry/presentation/shared/custom_dropdown.dart';
import 'package:qc_entry/presentation/survey/complete/screen/complete_page.dart';

class PartaiPage extends StatelessWidget {
  const PartaiPage({super.key});

  static const route = 'real-count/partai';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => getIt<PartaiProvider>()
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
    final partaiProvider = Provider.of<PartaiProvider>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Pemilihan Partai"),
        ),
        body: partaiProvider.isLoading
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
                          partaiProvider.dapilList.length,
                          (index) => DropdownMenuEntry(
                              value: index,
                              label: partaiProvider.dapilList[index].index),
                        ),
                        label: "Dapil",
                        onSelected: (selectedItems) {
                          kelurahanTextEditingController.clear();
                          partaiProvider.setSelectedKelurahanIndex(null);
                          partaiProvider.setSelectedDapilIndex(selectedItems);
                        },
                      ),
                      const SizedBox(height: 12),
                      QCEntryDropdown(
                        textEditingController: kelurahanTextEditingController,
                        items: List.generate(
                            partaiProvider.selectedDapilIndex != null
                                ? partaiProvider
                                    .dapilList[
                                        partaiProvider.selectedDapilIndex!]
                                    .kelurahan
                                    .length
                                : 0,
                            (index) => DropdownMenuEntry(
                                value: index,
                                label: partaiProvider
                                    .dapilList[
                                        partaiProvider.selectedDapilIndex!]
                                    .kelurahan[index])),
                        label: "Kelurahan",
                        onSelected: (selectedItems) {
                          partaiProvider
                              .setSelectedKelurahanIndex(selectedItems);
                        },
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        onChanged: (value) => partaiProvider.setTPS(value),
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
                            partaiProvider.setJumlahDPT(value),
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
                        "Suara per Partai",
                        style: AppTextStyle.heading5
                            .setSemiBold()
                            .copyWith(color: AppColor.secondaryColor),
                      ),
                      const SizedBox(height: 20),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => VoiceTextField(
                            label: partaiProvider.partaiList[index].nama,
                            onChange: partaiProvider.changePresidentVoiceCount,
                            index: index),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemCount: partaiProvider.partaiList.length,
                      ),
                      const Divider(),
                      VoiceTextField(
                        label: "Suara Tidak Sah",
                        onChangeNormal: partaiProvider.setUnsuccessfulVotes,
                      ),
                      const SizedBox(height: 24),
                      EnumeratorNotes(
                          onChange: partaiProvider.setEnumeratorNotes),
                      const SizedBox(height: 24),
                      QCEntryButton(
                        title: "Kirim",
                        onTap: () {
                          partaiProvider.submitPartai().then((value) {
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
