import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qc_entry/core/extension/text_extension.dart';
import 'package:qc_entry/core/injector/injector.dart';
import 'package:qc_entry/core/theme/app_color.dart';
import 'package:qc_entry/core/theme/app_text.dart';
import 'package:qc_entry/presentation/real_count/pilpres/provider/pilpres_provider.dart';
import 'package:qc_entry/presentation/real_count/shared/enumerator_notes.dart';
import 'package:qc_entry/presentation/real_count/shared/voice_text_field.dart';
import 'package:qc_entry/presentation/shared/custom_.dart';
import 'package:qc_entry/presentation/shared/custom_button.dart';
import 'package:qc_entry/presentation/shared/custom_dropdown.dart';
import 'package:qc_entry/presentation/survey/complete/screen/complete_page.dart';

class PilpresPage extends StatelessWidget {
  const PilpresPage({super.key});

  static const route = 'real-count/pilpres';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => getIt<PilpresProvider>()
          ..getData().then((value) {
            if (value != null) {
              showQCEntrySnackBar(context: context, title: value);
            }
          }),
        child: const PilpresView());
  }
}

class PilpresView extends StatefulWidget {
  const PilpresView({super.key});

  @override
  State<PilpresView> createState() => _PilpresViewState();
}

class _PilpresViewState extends State<PilpresView> {
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
    final pilpresProvider = Provider.of<PilpresProvider>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Pemilihan Presiden"),
        ),
        body: pilpresProvider.isLoading
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
                          pilpresProvider.dapilList.length,
                          (index) => DropdownMenuEntry(
                              value: index,
                              label: pilpresProvider.dapilList[index].index),
                        ),
                        label: "Dapil",
                        onSelected: (selectedItems) {
                          kelurahanTextEditingController.clear();
                          pilpresProvider.setSelectedKelurahanIndex(null);
                          pilpresProvider.setSelectedDapilIndex(selectedItems);
                        },
                      ),
                      const SizedBox(height: 12),
                      QCEntryDropdown(
                        textEditingController: kelurahanTextEditingController,
                        items: List.generate(
                            pilpresProvider.selectedDapilIndex != null
                                ? pilpresProvider
                                    .dapilList[
                                        pilpresProvider.selectedDapilIndex!]
                                    .kelurahan
                                    .length
                                : 0,
                            (index) => DropdownMenuEntry(
                                value: index,
                                label: pilpresProvider
                                    .dapilList[
                                        pilpresProvider.selectedDapilIndex!]
                                    .kelurahan[index])),
                        label: "Kelurahan",
                        onSelected: (selectedItems) {
                          pilpresProvider
                              .setSelectedKelurahanIndex(selectedItems);
                        },
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        onChanged: (value) => pilpresProvider.setTPS(value),
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
                            pilpresProvider.setJumlahDPT(value),
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
                        "Suara per Presiden",
                        style: AppTextStyle.heading5
                            .setSemiBold()
                            .copyWith(color: AppColor.secondaryColor),
                      ),
                      const SizedBox(height: 20),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => VoiceTextField(
                            label: pilpresProvider.capresList[index].namaPaslon,
                            onChange: pilpresProvider.changePresidentVoiceCount,
                            index: index),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemCount: pilpresProvider.capresList.length,
                      ),
                      const Divider(),
                      VoiceTextField(
                        label: "Suara Tidak Sah",
                        onChangeNormal: pilpresProvider.setUnsuccessfulVotes,
                      ),
                      const SizedBox(height: 24),
                      EnumeratorNotes(
                          onChange: pilpresProvider.setEnumeratorNotes),
                      const SizedBox(height: 24),
                      QCEntryButton(
                        title: "Kirim",
                        onTap: () {
                          pilpresProvider.cubmitPilpres().then((value) {
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
