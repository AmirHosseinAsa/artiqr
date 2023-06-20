import 'package:artiqr/models/generate_image_record.dart';
import 'package:artiqr/models/generated_image_records_database%20copy.dart';
import 'package:artiqr/widgets/record_show_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ResultContainer extends StatelessWidget {
  ResultContainer({Key? key, required this.showHistory}) : super(key: key);
  bool showHistory = false;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Consumer<GeneratedImageRecordsDatabase>(
                  builder: (context, generatedImageRecords, child) {
                    List<GenerateImageRecord> result =
                        generatedImageRecords.GenerateImages.where(
                            (e) => e.isBrandNew != showHistory).toList();
                    if (result.isNotEmpty) {
                      return ListView.builder(
                        shrinkWrap: true,
                        reverse: true,
                            physics: const BouncingScrollPhysics(),
                        itemCount: result.length,
                        itemBuilder: (BuildContext context, int index) {
                          return RecordShowWidget(
                            generateImageRecord: result[index],
                          );
                        },
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}