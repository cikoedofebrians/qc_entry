import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qc_entry/core/extension/text_extension.dart';
import 'package:qc_entry/core/injector/injector.dart';
import 'package:qc_entry/core/theme/app_color.dart';
import 'package:qc_entry/core/theme/app_text.dart';
import 'package:qc_entry/data/repository/raelcount_repository.dart';
import 'package:qc_entry/presentation/shared/custom_button.dart';
import 'package:qc_entry/presentation/shared/custom_dropdown.dart';
import 'package:qc_entry/presentation/shared/custom_snackbar.dart';
import 'package:qc_entry/presentation/survey/list/component/survey_list_item.dart';
import 'package:qc_entry/presentation/survey/surveyor_data/provider/respondent_data_provider.dart';
import 'package:qc_entry/presentation/survey/take/screen/survey_take_page.dart';

class RespondentDataPage extends StatelessWidget {
  const RespondentDataPage({super.key});

  static const route = '/survey/respondent-data';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments as SurveyTakeParams?;

    if (id == null) Navigator.of(context).pop();

    return ChangeNotifierProvider(
      create: (context) => RespondentDataProvider(
        getIt<RealcountRepository>(),
        id!,
      )..getData(),
      child: const RespondentDataView(),
    );
  }
}

class RespondentDataView extends StatefulWidget {
  const RespondentDataView({super.key});

  @override
  State<RespondentDataView> createState() => _RespondentDataViewState();
}

class _RespondentDataViewState extends State<RespondentDataView> {
  late final TextEditingController kelurahanTextController;

  @override
  void initState() {
    kelurahanTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    kelurahanTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final RespondentDataProvider respondentDataProvider =
        Provider.of<RespondentDataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Responden"),
      ),
      body: respondentDataProvider.isLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Text(
                    "SEBELUM MENGISI SURVEY, HARAP ISI DATA-DATA BERIKUT INI",
                    style: AppTextStyle.heading5
                        .setSemiBold()
                        .copyWith(color: AppColor.primaryColor),
                  ),
                  const SizedBox(height: 20),
                  QCEntryDropdown(
                    // textEditingController: dapilTextEditingController,
                    items: List.generate(
                      respondentDataProvider.dapilList.length,
                      (index) => DropdownMenuEntry(
                          value: index,
                          label: respondentDataProvider.dapilList[index].index),
                    ),
                    label: "Dapil",
                    onSelected: (selectedItems) {
                      kelurahanTextController.clear();
                      respondentDataProvider.setSelectedKelurahanIndex(null);
                      respondentDataProvider
                          .setSelectedDapilIndex(selectedItems);
                    },
                  ),
                  const SizedBox(height: 12),
                  QCEntryDropdown(
                    textEditingController: kelurahanTextController,
                    items: List.generate(
                        respondentDataProvider.selectedDapilIndex != null
                            ? respondentDataProvider
                                .dapilList[
                                    respondentDataProvider.selectedDapilIndex!]
                                .kelurahan
                                .length
                            : 0,
                        (index) => DropdownMenuEntry(
                            value: index,
                            label: respondentDataProvider
                                .dapilList[
                                    respondentDataProvider.selectedDapilIndex!]
                                .kelurahan[index])),
                    label: "Kelurahan",
                    onSelected: (selectedItems) {
                      respondentDataProvider
                          .setSelectedKelurahanIndex(selectedItems);
                    },
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    onChanged: respondentDataProvider.setRespondentName,
                    decoration: InputDecoration(
                        label: Text(
                          "Nama Responden",
                          style: AppTextStyle.body3
                              .setSemiBold()
                              .copyWith(color: AppColor.primaryColor),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  const Spacer(),
                  QCEntryButton(
                    title: "Mulai Survey",
                    onTap: () {
                      final check =
                          respondentDataProvider.checkRespondentData();
                      if (check != null) {
                        showQCEntrySnackBar(context: context, title: check);
                      } else {
                        final arg = {
                          "id": respondentDataProvider.id,
                          "kecamatan": respondentDataProvider.kecamatan,
                          "kelurahan": respondentDataProvider
                                  .dapilList[respondentDataProvider
                                      .selectedDapilIndex!]
                                  .kelurahan[
                              respondentDataProvider.selectedKelurahanIndex!],
                          "respondent_name":
                              respondentDataProvider.respondentName,
                        };

                        Navigator.of(context).pushReplacementNamed(
                          SurveyTakePage.route,
                          arguments: arg,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
