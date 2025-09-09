import 'package:flutter/material.dart';
import '../controller/search_lead_controller.dart';
import '../model/search_lead_model.dart';
import '../utils/app_constant.dart';

class SearchLeadScreen extends StatefulWidget {
  const SearchLeadScreen({Key? key}) : super(key: key);

  @override
  State<SearchLeadScreen> createState() => _SearchLeadScreenState();
}

class _SearchLeadScreenState extends State<SearchLeadScreen> {
  final TextEditingController leadIdController = TextEditingController();
  SearchLead? searchedLead;
  bool isLoading = false;

  void _searchLead() async {
    setState(() => isLoading = true);
    final lead = await LeadService.searchLeadById(leadIdController.text.trim());
    setState(() {
      searchedLead = lead;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: AppConstant.appInsideColor,
        title: Text(
          'Search Lead',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color:  AppConstant.appTextColor,
          ),
        ),
        iconTheme: IconThemeData(color: AppConstant.appIconColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: leadIdController,
              decoration: const InputDecoration(
                labelText: "Enter Lead ID",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _searchLead,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                elevation: 5,
                shadowColor: Colors.black54,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.search, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    "Search",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            if (isLoading) const CircularProgressIndicator(),
            if (!isLoading && searchedLead != null)
              Card(
                child: ListTile(
                  title: Text(searchedLead!.customerName),
                  subtitle: Text("Mobile: ${searchedLead!.mobile}\n"
                      "Lead ID: ${searchedLead!.leadId}\n"
                      "Client: ${searchedLead!.clientName}"),
                ),
              ),
            if (!isLoading && searchedLead == null)
              const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
