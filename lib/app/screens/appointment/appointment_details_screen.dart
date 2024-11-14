import 'package:flutter/material.dart';
import 'package:iclinix/app/widget/custom_app_bar.dart';
import 'package:iclinix/app/widget/custom_card_container.dart';
import 'package:iclinix/app/widget/custom_containers.dart';
import 'package:iclinix/data/models/response/appointment_history_model.dart';
import 'package:iclinix/utils/dimensions.dart';
import 'package:iclinix/utils/sizeboxes.dart';
import 'package:iclinix/utils/styles.dart';
import 'package:iclinix/utils/themes/light_theme.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  final AppointmentHistoryModel appointmentHistoryModel;

  const AppointmentDetailsScreen({super.key, required this.appointmentHistoryModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Appointment Details',isBackButtonExist: true,),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomDecoratedContainer(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle('Patient Information:'),
                      _buildInfoRow('Name:', '${appointmentHistoryModel.initial} ${appointmentHistoryModel.firstName} ${appointmentHistoryModel.lastName}'),
                      _buildInfoRow('Mobile No:', appointmentHistoryModel.mobileNo),
                      _buildInfoRow('Email:', appointmentHistoryModel.emailAddress ?? 'N/A'),
                      _buildInfoRow('Date of Birth:', appointmentHistoryModel.dob.toLocal().toString().split(' ')[0]),
                      _buildInfoRow('Age:', '${appointmentHistoryModel.ageYear} years, ${appointmentHistoryModel.ageMonth} months'),
                    ],
                  ),
                ), ),
            sizedBoxDefault(),
            CustomDecoratedContainer(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Appointment Information'),
                    for (var appointment in appointmentHistoryModel.patientAppointments) ...[
                      _buildInfoRow('Appointment ID:', appointment.id.toString()),
                      _buildInfoRow('Branch Name:', appointment.branchName),
                      _buildInfoRow('OPD Date:', appointment.opdDate.toLocal().toString().split(' ')[0]),
                      _buildInfoRow('OPD Time:', appointment.opdTime ?? 'N/A'),
                      _buildInfoRow('Doctor Name:', appointment.doctorName ?? 'N/A'),
                      _buildInfoRow('Category:', appointment.categoryName),
                      _buildDivider(),
                    ],

                  ],
                ),
              ), ),




            // Appointment Information Section
            // _buildSectionTitle('Appointment Information'),
            //
            // // Additional Information Section
            // _buildSectionTitle('Additional Information'),
            // _buildInfoRow('Source Name:', appointmentHistoryModel.sourceName ?? 'N/A'),
            // _buildInfoRow('Occupation:', appointmentHistoryModel.occupation ?? 'N/A'),
            // _buildInfoRow('Address:',
            //     '${appointmentHistoryModel.patientAddress ?? 'N/A'}, ${appointmentHistoryModel.cityName ?? 'N/A'}, ${appointmentHistoryModel.stateName ?? 'N/A'}, ${appointmentHistoryModel.countryName ?? 'N/A'}'),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: openSansSemiBold.copyWith(
          fontSize: Dimensions.fontSize14,
          color: primaryColor
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: openSansRegular.copyWith(
            fontSize: Dimensions.fontSize12,
            color: hintColor
          )),
          Expanded(child: Text(value, textAlign: TextAlign.end,
            style: openSansSemiBold.copyWith(
              fontSize: Dimensions.fontSize12,color: Colors.black.withOpacity(0.80)
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 20, color: Colors.grey);
  }
}
