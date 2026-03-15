import 'package:flutter/material.dart';
import 'package:cardx_survey_monkey/cardx_survey_monkey.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00BF6F)),
      ),
      home: const SurveyExamplePage(),
    );
  }
}

class SurveyExamplePage extends StatefulWidget {
  const SurveyExamplePage({super.key});

  @override
  State<SurveyExamplePage> createState() => _SurveyExamplePageState();
}

class _SurveyExamplePageState extends State<SurveyExamplePage> {
  final _cardxSurveyMonkeyPlugin = CardxSurveyMonkey();
  bool _isLoading = false;
  final _exampleHash = "LBQK27G";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                ),
                child: const Icon(Icons.poll_rounded,
                    size: 60, color: Color(0xFF00BF6F)),
              ),
              const SizedBox(height: 30),
              const Text("Customer Feedback",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text("We'd love to hear your thoughts!",
                  style: TextStyle(color: Colors.grey[600])),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00BF6F),
                    foregroundColor: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _isLoading
                      ? null
                      : () async {
                          setState(() => _isLoading = true);
                          try {
                            await _cardxSurveyMonkeyPlugin
                                .showSurvey(_exampleHash);
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Error: $e")));
                            }
                          } finally {
                            setState(() => _isLoading = false);
                          }
                        },
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("START SURVEY",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
