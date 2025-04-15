import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_backend_1/screens/Home/home_screen.dart';
import 'package:flutter_backend_1/screens/pages/Menu/addPic.dart';
import 'package:flutter_backend_1/screens/pages/service/database.dart';
import 'package:flutter_backend_1/static/colors.dart';
import 'package:flutter_backend_1/widget/custumDropDown.dart';
import 'package:flutter_backend_1/widget/textfieldcreate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';
import 'package:rich_typewriter/rich_typewriter.dart';
import 'package:zo_animated_border/widget/zo_dotted_border.dart';

class MultiFormPage extends StatefulWidget {
  const MultiFormPage({super.key});

  @override
  State<MultiFormPage> createState() => _MultiFormPageState();
}

class _MultiFormPageState extends State<MultiFormPage> {
  int currentStep = 0;

  bool get isFirstStep => currentStep == 0;
  bool get isLastStep => currentStep == steps().length - 1;

  bool isComplete = false;

  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController genreController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? selectedGenre;
  File? _bookCover;

  final List<String> genres = [
    'none',
    'Action/Adventure',
    'Biography/Autobiography',
    'Children\'s Fiction',
    'Classics',
    'Contemporary Fiction',
    'Crime/Thriller',
    'Detective/Mystery',
    'Fantasy',
    'Historical Fiction',
    'Horror',
    'Literary Fiction',
    'Magical Realism',
    'Memoir',
    'Non-Fiction',
    'Philosophy',
    'Poetry',
    'Psychology',
    'Romance',
    'Science Fiction',
    'Self-Help',
    'Spirituality/Religion',
    'Suspense',
    'Technology/Computers',
    'Thriller',
    'Travel',
    'Young Adult (YA)',
    'Science',
    'Adventure',
    'Historical Romance',
    'Military Fiction',
    'Western',
    'True Crime',
    'Health & Wellness',
    'Cookbooks/Food',
    'Business & Economics',
    'Arts & Photography',
  ];

  Future<void> _pickCoverImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _bookCover = File(pickedFile.path);
      });
    }
  }

  final TextEditingController _publicationDateController =
      TextEditingController();
  final TextEditingController _languageController =
      TextEditingController(); // lowercase 'L' in 'language'
  final TextEditingController _KeyWordsController = TextEditingController();
  final TextEditingController _PubInfoController = TextEditingController();
  final TextEditingController _PriceController = TextEditingController();
  final TextEditingController _BookLenController = TextEditingController();
  final TextEditingController _BookLinkController = TextEditingController();
  final TextEditingController _SimilarBooksController = TextEditingController();
  final TextEditingController _BookExcerptController = TextEditingController();
  final TextEditingController _BookSeriesController = TextEditingController();
  final TextEditingController _BookSeriesInfoController =
      TextEditingController();

  String? _publishementType;
  final List<String> _pubTypes = ['Traditional Publishing', 'Self Publishing'];
  final List<String> _languages = [
    'Arabic',
    'French',
    'English',
  ]; // Fixed spelling of "French"

  String? _readingLevel = 'Beginner';
  String? _selectedLang;

  @override // ✅ Missing override
  void initState() {
    super.initState();
    final String formattedDate = DateFormat(
      'yyyy-MM-dd',
    ).format(DateTime.now());
    _publicationDateController.text = formattedDate;
  }

  @override
  void dispose() {
    _publicationDateController.dispose();
    _languageController.dispose();
    _KeyWordsController.dispose();
    _PubInfoController.dispose();
    _PriceController.dispose();
    _BookLenController.dispose();
    _BookLinkController.dispose();
    _SimilarBooksController.dispose();
    _BookExcerptController.dispose();
    _BookSeriesController.dispose();
    _BookSeriesInfoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF242038),
      body: Stepper(
        type: StepperType.horizontal,
        steps: steps(),
        currentStep: currentStep,
        onStepContinue: () async {
          //here i can make the navigation to the other page

          if (currentStep == 0) {
            if (_formKey1.currentState!.validate()) {
              setState(() => currentStep += 1);
            }
          } else if (currentStep == 1) {
            if (_formKey2.currentState!.validate()) {
              setState(() => currentStep += 1);
            }
          } else if (isLastStep) {
            if (_formKey1.currentState!.validate() &&
                _formKey2.currentState!.validate()) {
              setState(() => isComplete = true);
              String Id = randomAlphaNumeric(10);
              Map<String, dynamic> bookInfoMap = {
                "Id": Id,
                "title": titleController.text,
                "author": authorController.text,
                "descr": descriptionController.text,
                "pubDate": _publicationDateController.text,
                "Lang": _languageController.text,
                "Keywords": _KeyWordsController.text,
                "PubInfo": _PubInfoController.text,
                "price": _PriceController.text,
                "BookLen": _BookLenController.text,
                "BooKink": _BookLinkController.text,
                "SimBooks": _SimilarBooksController.text,
                "BookExcerpt": _BookExcerptController.text,
                "BookSeries": _BookSeriesController.text,
                "BookSeriesInfo": _BookSeriesController.text,
              };
              await DatabaseMethods().CreateAbook(bookInfoMap, Id).then((
                value,
              ) {
                Fluttertoast.showToast(
                  msg: "you have published a book successfuly",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Homepage()),
                );
              });
            }
          }
        },
        onStepCancel:
            isFirstStep ? null : () => setState(() => currentStep -= 1),
        onStepTapped: (step) => setState(() => currentStep = step),

        controlsBuilder:
            (context, details) => Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Row(
                children: [
                  if (isFirstStep) ...[
                    Expanded(
                      child: ZoDottedBorder(
                        animate: true,
                        borderRadius: 12,
                        dashLength: 10,
                        gapLength: 5,
                        strokeWidth: 3,
                        color: AppColors.electricPurple,
                        animationDuration: Duration(seconds: 4),
                        borderStyle: BorderStyleType.monochrome,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 16,
                            ),
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            setState(() => currentStep += 1);
                          },
                          child: Text(
                            isLastStep ? 'Publish Now' : 'Next',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ] else ...[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: details.onStepContinue,
                        child: Text(isLastStep ? 'Confirm' : 'Next'),
                      ),
                    ),
                    if (!isFirstStep) ...[
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: details.onStepCancel,
                          child: const Text('Back'),
                        ),
                      ),
                    ],
                  ],
                ],
              ),
            ),
      ),
    );
  }

  List<Step> steps() => [
    Step(
      state: currentStep > 0 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 0,
      title: Text('1'),
      content: Column(
        children: [
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 40),

                    // Adjust the Title and Remove Unnecessary Positioned Widget
                    Container(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: double.infinity, // Full width
                        child: RichTypewriter(
                          symbolDelay: (span) => 100,
                          child: const Text.rich(
                            TextSpan(
                              text: "    Ready to publish your book?",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontFamily: 'RozhaOne',
                              ),
                            ),
                            textAlign: TextAlign.center, // Align text to center
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 80),
                    SizedBox(height: 80),
                    SizedBox(
                      width: 333,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          'Have a literary voice the world needs to hear? From compelling essays to timeless poetry, sharp critiques to heartfelt fiction—Literature Media invites writers of every genre to bring their work to the public eye. Whether you seek to inform, inspire, or simply share your craft, now is the time to publish. Step into a space where literature thrives and voices matter.',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'RocknRollOne',
                          ),

                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: 80),
                    // The Button
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    Step(
      title: Text('2'),
      content: Column(
        children: [
          SingleChildScrollView(
            child: Container(
              color: const Color.fromARGB(255, 167, 160, 176),

              width: double.infinity,
              height: 1200,
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 600),
                  child: Form(
                    key: _formKey1,
                    child: Column(
                      children: [
                        SizedBox(height: 30),

                        // Book Cover Upload Section
                        GestureDetector(
                          onTap: _pickCoverImage,
                          child: Container(
                            width: 150,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: const Color.fromARGB(255, 248, 247, 255),
                                width: 2,
                              ),
                              image:
                                  _bookCover != null
                                      ? DecorationImage(
                                        image: FileImage(_bookCover!),
                                        fit: BoxFit.cover,
                                      )
                                      : null,
                            ),
                            child:
                                _bookCover == null
                                    ? Center(
                                      child: Text(
                                        'Upload Cover',
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                    )
                                    : null,
                          ),
                        ),
                        SizedBox(height: 30),
                        SizedBox(height: 30),

                        // Title Input
                        SizedBox(
                          height: 90,
                          width: 340,
                          child: Textfieldcreate(
                            text1: 'Book Title',
                            text2: 'Ex : ',
                            prefix: Icon(Icons.title),
                            suffix: Icon(null),
                            obscureText: false,
                            controller: titleController,
                            decoration: _inputDecoration('Book Title'),
                            validator:
                                (value) =>
                                    value == null || value.isEmpty
                                        ? 'Enter title'
                                        : null,
                          ),
                        ),
                        SizedBox(height: 27),

                        // Author Input
                        SizedBox(
                          height: 90,
                          width: 340,
                          child: Textfieldcreate(
                            text1: 'Author Name',
                            text2: 'Ex : Mohammed Dib',
                            prefix: Icon(Icons.person),
                            suffix: Icon(null),
                            obscureText: false,
                            controller: authorController,
                            decoration: _inputDecoration('Author Name'),
                            validator:
                                (value) =>
                                    value == null || value.isEmpty
                                        ? 'Enter author'
                                        : null,
                          ),
                        ),
                        SizedBox(height: 27),

                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 14),
                          child: Text(
                            'Select a Genre',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),

                        SizedBox(height: 10),
                        // First Genre Dropdown
                        SizedBox(
                          height: 90,
                          width: 340,
                          child: _buildDropdown('Select Genre'),
                        ),
                        SizedBox(height: 16),

                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 14),
                          child: Text(
                            'Select a second Genre',
                            style: TextStyle(fontSize: 16),
                          ),
                        ), // Second Genre Dropdown
                        SizedBox(height: 10),
                        SizedBox(
                          height: 90,
                          width: 340,
                          child: _buildDropdown('Select Second Genre'),
                        ),
                        SizedBox(height: 16),

                        // Description
                        SizedBox(
                          width: 340,
                          child: _buildMultilineField(
                            descriptionController,
                            'Book Description',
                            5,
                            1000,
                          ),
                        ),
                        SizedBox(height: 16),

                        // Target audience
                        SizedBox(
                          width: 340,
                          child: _buildMultilineField(
                            null,
                            'Target Audience',
                            3,
                            500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ), // Set width to fill the available space
          ),
        ],
      ),
    ),
    Step(
      state: currentStep > 0 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 2,
      title: Text('Complete'),
      content: Column(
        children: [
          SingleChildScrollView(
            child: Container(
              color: const Color.fromARGB(255, 167, 160, 176),

              width: double.infinity,
              height: 2000,
              child: Form(
                key: _formKey2,
                child: Column(
                  children: [
                    SizedBox(height: 80),

                    SizedBox(
                      height: 150,
                      width: 340,
                      child: Textfieldcreate(
                        text1: 'Keywords', // Just example text
                        text2: '',
                        prefix: Icon(Icons.tag),
                        suffix: Icon(null),
                        obscureText: false,
                        controller: _KeyWordsController,
                        minLines: 3,

                        decoration: _inputDecoration('Keywords/Tags'),
                        validator:
                            (value) =>
                                value == null || value.isEmpty
                                    ? 'Enter keywords'
                                    : null,
                      ),
                    ),
                    SizedBox(height: 27),

                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 18),
                      child: Text(
                        'Select Language',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 80,
                      width: 340,
                      child: _buildDropdown('Select Language'),
                    ),
                    SizedBox(height: 27),
                    TextFormField(
                      controller: _publicationDateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Publication Date',
                      ),
                    ),
                    SizedBox(height: 27),

                    DropdownButtonFormField<String>(
                      value: _publishementType,
                      decoration: InputDecoration(
                        labelText: 'Publishement Type',
                      ),
                      items:
                          _pubTypes.map((type) {
                            return DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            );
                          }).toList(),
                      onChanged: (val) {
                        setState(() {
                          _publishementType = val;
                        });
                      },
                    ),
                    SizedBox(height: 27),
                    if (_publishementType == 'Traditional Publishing') ...[
                      SizedBox(
                        height: 110,
                        width: 340,
                        child: Textfieldcreate(
                          text1: 'Publisher info', // Just example text
                          text2: '',
                          prefix: Icon(Icons.tag),
                          suffix: Icon(null),
                          obscureText: false,

                          controller: _PubInfoController,
                          decoration: _inputDecoration('Publisher info'),
                          validator:
                              (value) =>
                                  value == null || value.isEmpty
                                      ? 'Enter Publisher'
                                      : null,
                        ),
                      ),
                    ],

                    SizedBox(
                      height: 110,
                      width: 340,
                      child: Textfieldcreate(
                        text1: 'Price', // You can customize this label
                        text2:
                            '', // Optional second text (if not used, keep empty)
                        prefix: Icon(
                          Icons.attach_money,
                        ), // You can change this icon if needed
                        suffix: Icon(
                          null,
                        ), // Add a suffix icon or widget if required
                        obscureText:
                            false, // Since it's a price, no need to obscure the text
                        controller: _PriceController,
                        keyboardType: TextInputType.number,

                        decoration: _inputDecoration('Price'),
                        validator:
                            (value) =>
                                value == null || value.isEmpty
                                    ? 'Enter price'
                                    : null,
                      ),
                    ),
                    SizedBox(height: 27),

                    SizedBox(
                      height: 110,
                      width: 340,
                      child: Textfieldcreate(
                        text1: 'Book Length', // Label or heading text
                        text2: '',
                        keyboardType: TextInputType.number,
                        // Optional subtext or hint, you can customize it
                        prefix: Icon(
                          Icons.menu_book_outlined,
                        ), // Optional, use any relevant icon
                        suffix: Icon(
                          null,
                        ), // Add a suffix widget if needed (like unit: pages)
                        obscureText: false, // No need to obscure this field
                        controller: _BookLenController,
                        decoration: _inputDecoration('Book Length'),
                        validator:
                            (value) =>
                                value == null || value.isEmpty
                                    ? 'Enter book length'
                                    : null,
                      ),
                    ),
                    SizedBox(height: 27),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 14),
                          child: Text(
                            'Reading Level',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text('Beginner'),
                          leading: Radio<String>(
                            value: 'Beginner',
                            groupValue: _readingLevel,
                            onChanged: (value) {
                              setState(() {
                                _readingLevel = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: Text('Intermediate'),
                          leading: Radio<String>(
                            value: 'Intermediate',
                            groupValue: _readingLevel,
                            onChanged: (value) {
                              setState(() {
                                _readingLevel = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: Text('Advanced'),
                          leading: Radio<String>(
                            value: 'Advanced',
                            groupValue: _readingLevel,
                            onChanged: (value) {
                              setState(() {
                                _readingLevel = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 27),

                    SizedBox(
                      height: 110,
                      width: 340,
                      child: Textfieldcreate(
                        text1: 'Book Excerpt', // Main label
                        text2: '', // Optional sublabel or hint text
                        prefix: Icon(
                          Icons.notes,
                        ), // Icon that fits the idea of an excerpt
                        suffix: Icon(
                          null,
                        ), // Optional, add something like character count if needed
                        obscureText:
                            false, // No need to hide text in an excerpt field
                        controller:
                            _BookLenController, // <-- Consider renaming this to _BookExcerptController
                        decoration: _inputDecoration('Book Excerpt'),
                        validator:
                            (value) =>
                                value == null || value.isEmpty
                                    ? 'Enter book excerpt'
                                    : null,
                      ),
                    ),
                    SizedBox(height: 27),

                    SizedBox(
                      height: 110,
                      width: 340,
                      child: Textfieldcreate(
                        text1: 'Book Series',
                        text2: '', // Optional sublabel or hint
                        prefix: Icon(
                          Icons.collections_bookmark,
                        ), // Suitable icon for a series
                        suffix: Icon(
                          null,
                        ), // Optional: maybe an info icon if needed
                        obscureText: false, // No need to obscure
                        controller:
                            _BookLenController, // Consider renaming this to _BookSeriesController
                        decoration: _inputDecoration('Book Series'),
                        validator:
                            (value) =>
                                value == null || value.isEmpty
                                    ? 'Enter book series'
                                    : null,
                      ),
                    ),
                    SizedBox(height: 27),

                    SizedBox(
                      height: 110,
                      width: 340,

                      child: Textfieldcreate(
                        text1: 'Book Series Info',
                        text2: '', // Optional sublabel or description
                        prefix: Icon(
                          Icons.info_outline,
                        ), // Info icon suits this label
                        suffix: Icon(null), // Optional: add something if needed
                        obscureText: false,
                        controller: _BookLenController,
                        minLines:
                            2, // Suggestion: rename to _BookSeriesInfoController
                        decoration: _inputDecoration('Book Series Info'),
                        validator: (value) => null,
                      ),
                    ),
                    SizedBox(height: 27),

                    SizedBox(
                      height: 110,
                      width: 340,
                      child: Textfieldcreate(
                        text1: 'Similar Books',
                        text2: 'Enter titles separated by commas',
                        prefix: Icon(Icons.book_outlined),
                        suffix: Icon(null),
                        obscureText: false,
                        controller:
                            _SimilarBooksController, // Consider creating this controller separately
                        decoration: _inputDecoration(
                          'Similar Books (comma-separated)',
                        ),
                        minLines: 2,
                        validator: (value) => null,
                      ),
                    ),
                    SizedBox(height: 27),

                    SizedBox(
                      height: 110,
                      width: 340,
                      child: Textfieldcreate(
                        text1: 'Book Website or Social Media',
                        text2: 'Enter a valid URL or handle',
                        prefix: Icon(Icons.link),
                        suffix: Icon(null),
                        obscureText: false,
                        controller:
                            _BookLinkController, // Consider renaming from _BookLenController
                        decoration: _inputDecoration(
                          'Book Website or Social Media Link',
                        ),
                        validator:
                            (value) =>
                                value == null || value.isEmpty
                                    ? 'Enter the book website or social media link'
                                    : null,
                      ),
                    ),

                    SizedBox(height: 27),
                    FileUploadForm(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  ];

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: AppColors.vibrantBlue, width: 3),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: AppColors.vibrantBlue, width: 3),
      ),
      filled: true,
      fillColor: const Color(0xFFF7ECE1),
    );
  }

  Widget buildTextField(String label, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          hintText:
              label == 'Book Excerpt'
                  ? 'e.g., A powerful paragraph or quote from your book...'
                  : null,
          border: OutlineInputBorder(),
        ),
        maxLines: maxLines,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildMultilineField(
    TextEditingController? controller,
    String label,
    int minLines,
    int maxLength,
  ) {
    return Textfieldcreate(
      text1: label, // Use the label as the main text
      text2: 'Enter your $label here', // Optional hint text
      prefix: Icon(Icons.edit), // You can customize the prefix icon
      suffix: Icon(null), // You can add a suffix if needed
      obscureText: false, // Set to true if you want to obscure text
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label'; // Custom validation message
        }
        return null; // Return null if validation passes
      },
      keyboardType: TextInputType.multiline, // Set keyboard type for multiline
      minLines: minLines, // Set minimum lines
      maxLength: maxLength,
      decoration: InputDecoration(), // Set maximum length
    );
  }

  Widget _buildDropdown(String hint) {
    return SizedBox(
      height: 90,
      width: 340,
      child: CustomDropdown<String>(
        value: selectedGenre, // The currently selected value
        items:
            genres.map((genre) {
              return DropdownMenuItem<String>(value: genre, child: Text(genre));
            }).toList(),
        hintText: hint,
        onChanged: (value) {
          setState(() {
            selectedGenre = value; // Update the selected genre
          });
        },
        validator: (value) => value == null ? 'Please select a genre' : null,
        prefixIcon: Icon(Icons.category), // Optional prefix icon
        suffixIcon: null, // Optional suffix icon
      ),
    );
  }
}



 /* Widget _buildMultilineField(
    TextEditingController? controller,
    String label,
    int minLines,
    int maxLength,
  ) {
    return TextFormField(
      controller: controller,
      minLines: minLines,
      maxLines: minLines + 3,
      maxLength: maxLength,
      style: TextStyle(fontSize: 16.0),
      decoration: _inputDecoration(label),
    );
  }
}


isComplete
              ? buildSuccessPage()
              : Stepper( */