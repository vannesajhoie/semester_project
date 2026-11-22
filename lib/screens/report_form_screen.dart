import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';

enum ReportUiState { idle, loading, success, empty, error }

class ReportFormScreen extends StatefulWidget {
  const ReportFormScreen({super.key});

  @override
  State<ReportFormScreen> createState() => _ReportFormScreenState();
}

class _ReportFormScreenState extends State<ReportFormScreen> {
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();

  ReportUiState _uiState = ReportUiState.idle;
  bool _simulateFailure = false;

  Future<void> submitReport() async {
    if (_titleController.text.trim().isEmpty ||
        _locationController.text.trim().isEmpty ||
        _descriptionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields.')),
      );
      return;
    }

    if (_titleController.text.trim().length < 3 ||
        _locationController.text.trim().length < 3 ||
        _descriptionController.text.trim().length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('All fields must contain at least 3 characters.'),
        ),
      );
      return;
    }

    setState(() {
      _uiState = ReportUiState.loading;
    });

    try {
      // Simulated submission only. No database connection.
      await Future<void>.delayed(const Duration(seconds: 3));

      if (_simulateFailure) {
        throw Exception('Simulated failure');
      }

      if (!mounted) return;

      setState(() {
        _uiState = ReportUiState.success;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _uiState = ReportUiState.error;
      });
    }
  }

  void showEmptyState() {
    setState(() {
      _uiState = ReportUiState.empty;
    });
  }

  void showForm() {
    setState(() {
      _uiState = ReportUiState.idle;
    });
  }

  void resetForm() {
    _titleController.clear();
    _locationController.clear();
    _descriptionController.clear();

    setState(() {
      _uiState = ReportUiState.idle;
      _simulateFailure = false;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        title: const Text('Report Form'),
        backgroundColor: kGreen,
        actions: [
          TextButton(
            onPressed: showEmptyState,
            child: const Text('My Reports'),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 650),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: _buildContent(),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (_uiState) {
      case ReportUiState.loading:
        return _buildLoading();
      case ReportUiState.success:
        return _buildSuccess();
      case ReportUiState.empty:
        return _buildEmpty();
      case ReportUiState.error:
        return _buildError();
      case ReportUiState.idle:
        return _buildForm();
    }
  }

  Widget _buildForm() {
    return Card(
      color: kCard,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          shrinkWrap: true,
          children: [
            const Text(
              'Submit a Report',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Fill in the details below to create a report.',
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 24),

            // Reusable text field from lib/widgets/
            AppTextField(
              label: 'Report Title',
              controller: _titleController,
            ),

            AppTextField(
              label: 'Location',
              controller: _locationController,
            ),

            AppTextField(
              label: 'Description',
              controller: _descriptionController,
            ),

            const SizedBox(height: 12),

            SwitchListTile(
              title: const Text(
                'Simulate submission failure',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: const Text(
                'Demo only: turn on to display Error state.',
                style: TextStyle(color: Colors.white70),
              ),
              value: _simulateFailure,
              onChanged: (value) {
                setState(() {
                  _simulateFailure = value;
                });
              },
            ),

            const SizedBox(height: 16),

            // Reusable button from lib/widgets/
            AppButton(
              label: 'Submit Report',
              onPressed: submitReport,
              color: kGreen,
            ),

            const SizedBox(height: 12),

            AppButton(
              label: 'View My Reports (Empty Demo)',
              onPressed: showEmptyState,
              color: kGreen,
              outline: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return Card(
      color: kCard,
      child: const Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 24),
            Text(
              'Submitting your report...',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Please wait. This is a simulated response.',
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccess() {
    return Card(
      color: kCard,
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 80,
            ),
            const SizedBox(height: 20),
            const Text(
              'Report submitted successfully!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'This submission was simulated. '
              'No database record was saved.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 24),
            AppButton(
              label: 'Submit Another Report',
              onPressed: resetForm,
              color: kGreen,
            ),
            const SizedBox(height: 8),
            AppButton(
              label: 'View My Reports',
              onPressed: showEmptyState,
              color: kGreen,
              outline: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Card(
      color: kCard,
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.inbox_outlined,
              size: 80,
              color: Colors.white70,
            ),
            const SizedBox(height: 20),
            const Text(
              'No Reports Available',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'There are no report records to display. '
              'This is an empty-state demonstration.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 24),
            AppButton(
              label: 'Create a Report',
              onPressed: showForm,
              color: kGreen,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError() {
    return Card(
      color: kCard,
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              size: 80,
              color: Colors.red,
            ),
            const SizedBox(height: 20),
            const Text(
              'Something went wrong!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'The submission failed in this simulated scenario. '
              'Please try again.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 24),
            AppButton(
              label: 'Retry',
              onPressed: submitReport,
              color: kGreen,
            ),
            const SizedBox(height: 8),
            AppButton(
              label: 'Edit Report',
              onPressed: showForm,
              color: kGreen,
              outline: true,
            ),
          ],
        ),
      ),
    );
  }
}