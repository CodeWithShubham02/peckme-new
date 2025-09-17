import 'package:flutter/material.dart';
import 'package:peckme/controller/self_lead_alloter.dart';

import '../model/self_lead_model.dart';

class LeadCheckScreen extends StatefulWidget {
  final String uid;
  final String branchId;

  const LeadCheckScreen({Key? key, required this.uid, required this.branchId})
    : super(key: key);

  @override
  State<LeadCheckScreen> createState() => _LeadCheckScreenState();
}

class _LeadCheckScreenState extends State<LeadCheckScreen> {
  final TextEditingController _mobileController = TextEditingController();
  SelfLeadAlloterModel? _lead;
  bool _loading = false;
  SelfLeadAlloterService selfLeadAlloterService = SelfLeadAlloterService();

  Future<void> _checkLead() async {
    setState(() => _loading = true);

    try {
      final lead = await selfLeadAlloterService.checkLead(
        _mobileController.text.trim(),
        widget.branchId,
      );

      setState(() {
        _lead = lead;
        _loading = false;
      });

      if (lead != null) {
        // ✅ Lead exists
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("✅ 'Lead exists!'")));
      } else {
        // ❌ Lead not found
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("❌ Lead not found")));
      }
    } catch (e) {
      setState(() => _loading = false);

      // 🚨 API or service error
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
    }
  }

  Future<void> _assignLead() async {
    if (_lead == null) return;
    setState(() => _loading = true);
    final success = await selfLeadAlloterService.assignLead(
      _lead!.mobile,
      widget.uid,
      widget.branchId,
    );
    setState(() => _loading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success ? "Lead assigned ✅" : "Failed to assign lead ❌"),
      ),
    );
    if (success) {
      setState(() => _lead = null);
      _mobileController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Check & Assign Lead")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _mobileController,
              decoration: InputDecoration(
                labelText: "Enter Mobile Number",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: _loading
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.search),
                  onPressed: _loading
                      ? null
                      : _checkLead, // ✅ search icon पर click
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            if (_lead != null)
              Card(
                child: ListTile(
                  title: Text(_lead!.customerName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Lead ID: ${_lead!.leadId}"),
                      Text("Mobile: ${_lead!.mobile}"),
                      Text("Status ID: ${_lead!.statusId}"),
                      Text("Branch: ${_lead!.branchId}"),
                    ],
                  ),
                  trailing: ElevatedButton(
                    onPressed: _loading ? null : _assignLead,
                    child: const Text("Accept"),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
