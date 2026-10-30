import 'package:crafty_bay/presentation/ui/widgets/app_logo_widget.dart';
import 'package:flutter/material.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() =>
      _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  // Customer Controllers
  final TextEditingController _cusNameTEController = TextEditingController();
  final TextEditingController _cusAddTEController = TextEditingController();
  final TextEditingController _cusCityTEController = TextEditingController();
  final TextEditingController _cusStateTEController = TextEditingController();
  final TextEditingController _cusPostcodeTEController = TextEditingController();
  final TextEditingController _cusCountryTEController = TextEditingController();
  final TextEditingController _cusPhoneTEController = TextEditingController();
  final TextEditingController _cusFaxTEController = TextEditingController();

  // Shipping Controllers
  final TextEditingController _shipNameTEController = TextEditingController();
  final TextEditingController _shipAddTEController = TextEditingController();
  final TextEditingController _shipCityTEController = TextEditingController();
  final TextEditingController _shipStateTEController = TextEditingController();
  final TextEditingController _shipPostcodeTEController = TextEditingController();
  final TextEditingController _shipCountryTEController = TextEditingController();
  final TextEditingController _shipPhoneTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(child: AppLogoWidget()),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    'Complete Profile',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    'Get started with us by providing your information',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.black54),
                  ),
                ),
                const SizedBox(height: 24),

                // Customer Information Section
                Text(
                  'Customer Details',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _cusNameTEController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: "Customer Name"),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _cusAddTEController,
                  maxLines: 2,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: "Customer Address"),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _cusCityTEController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: "Customer City"),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _cusStateTEController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: "Customer State"),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _cusPostcodeTEController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: "Customer Postcode"),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _cusCountryTEController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: "Customer Country"),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _cusPhoneTEController,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: "Customer Phone"),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _cusFaxTEController,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: "Customer Fax"),
                ),
                const SizedBox(height: 24),

                // Shipping Information Section
                Text(
                  'Shipping Details',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _shipNameTEController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: "Shipping Name"),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _shipAddTEController,
                  maxLines: 2,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: "Shipping Address"),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _shipCityTEController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: "Shipping City"),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _shipStateTEController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: "Shipping State"),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _shipPostcodeTEController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: "Shipping Postcode"),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _shipCountryTEController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: "Shipping Country"),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _shipPhoneTEController,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(hintText: "Shipping Phone"),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Handle form submission
                  },
                  child: const Text('Complete'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cusNameTEController.dispose();
    _cusAddTEController.dispose();
    _cusCityTEController.dispose();
    _cusStateTEController.dispose();
    _cusPostcodeTEController.dispose();
    _cusCountryTEController.dispose();
    _cusPhoneTEController.dispose();
    _cusFaxTEController.dispose();

    _shipNameTEController.dispose();
    _shipAddTEController.dispose();
    _shipCityTEController.dispose();
    _shipStateTEController.dispose();
    _shipPostcodeTEController.dispose();
    _shipCountryTEController.dispose();
    _shipPhoneTEController.dispose();

    super.dispose();
  }
}