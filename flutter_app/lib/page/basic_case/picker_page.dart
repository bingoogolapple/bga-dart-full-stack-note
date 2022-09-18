import 'package:flutter/material.dart';

class ShowPickerPage extends StatefulWidget {
  const ShowPickerPage({super.key});

  @override
  State<ShowPickerPage> createState() => _ShowPickerPageState();
}

class _ShowPickerPageState extends State<ShowPickerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ShowPicker'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        children: [
          ElevatedButton(
            child: const Text('showDatePicker'),
            onPressed: () async {
              final DateTime? result = await showDatePicker(
                context: context,
                initialDate: DateTime.utc(2022, 9, 18),
                firstDate: DateTime.utc(2022, 8, 1),
                lastDate: DateTime.utc(2022, 9, 30),
                // helpText: '选择日期',
                // cancelText: '取消',
                // confirmText: '确定',
                // 只支持日期选择，不支持切换到手动输入
                initialEntryMode: DatePickerEntryMode.calendarOnly,
              );
              debugPrint('选择的日期为 ${result.toString()}');
            },
          ),
          ElevatedButton(
            child: const Text('showTimePicker'),
            onPressed: () async {
              final TimeOfDay? result = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
                // helpText: '选择时间',
                // cancelText: '取消',
                // confirmText: '确定',
                // 只支持选择时间，不支持输入时间
                initialEntryMode: TimePickerEntryMode.dialOnly,
                builder: (context, child) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      alwaysUse24HourFormat: true,
                    ),
                    child: child!,
                  );
                },
              );
              debugPrint('选择的时间为 ${result.toString()}');
            },
          ),
          ElevatedButton(
            child: const Text('showDateRangePicker'),
            onPressed: () async {
              final DateTimeRange? result = await showDateRangePicker(
                context: context,
                initialDateRange: DateTimeRange(
                  start: DateTime.utc(2022, 8, 10),
                  end: DateTime.utc(2022, 8, 15),
                ),
                firstDate: DateTime.utc(2022, 8, 1),
                lastDate: DateTime.utc(2022, 9, 30),
                // helpText: '选择日期',
                // saveText: '确定',
                // 只支持日期选择，不支持切换到手动输入
                initialEntryMode: DatePickerEntryMode.calendarOnly,
              );
              debugPrint('选择的时间范围为 ${result.toString()}');
            },
          ),
        ],
      ),
    );
  }
}
