import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nameController = TextEditingController(text: 'John Doe');
  final _emailController = TextEditingController(text: 'johndoe@example.com');
  final _phoneController = TextEditingController(text: '+1-123-456-7890');
  final _locationController = TextEditingController(text: 'New York, USA');
  final _bioController = TextEditingController(
      text:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.");
  bool _isEditing = false;
    final _formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    _bioController.dispose();
    super.dispose();
  }
  void _toggleEditMode(){
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveProfileChanges(){
    if (_formKey.currentState!.validate()){
       setState(() {
          _isEditing = false;
        });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile Updated")),
      );
    }
  }


  void _logout(){
    // TODO: Implement logout logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Logged Out Successfully")),
    );
    Navigator.pop(context); // go back to home screen
  }

  Widget _buildProfileInfoSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(title, style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          )),
        ),
        Container(
           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
           decoration: BoxDecoration(
               color: Colors.grey[100],
             borderRadius: BorderRadius.circular(12),
            ),
           child: content,
        ),
         const SizedBox(height: 15.0,),
      ],
    );
  }

  Widget _buildProfileTextField(TextEditingController controller, String label, TextInputType type){
       return TextFormField(
         controller: controller,
         decoration:  InputDecoration(
           labelText: label,
           border: InputBorder.none
         ),
         keyboardType: type,
         validator: (value) {
           if (value == null || value.isEmpty) {
             return 'Please enter $label';
           }
           return null;
         },
       );
  }

  Widget _buildReadOnlyProfileField(String label, IconData icon, String text){
    return  Row(
      children: [
        Icon(icon, color: Colors.grey[600],),
        const SizedBox(width: 10.0,),
        Expanded(
            child:  Text("$label: $text",
                style: const TextStyle(fontSize: 16, color: Colors.black87))),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: _toggleEditMode,
              icon: Icon(_isEditing ? Icons.cancel : Icons.edit, color: Colors.white,))
        ],
      ),
      body:  Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(70),
                  child: Image.asset(
                    "images/boy.png",
                    height: 140,
                    width: 140,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              _buildProfileInfoSection("Personal Info", Column(
                 children: [
                   if (_isEditing) _buildProfileTextField(_nameController, "Name", TextInputType.name)
                 else  _buildReadOnlyProfileField("Name", Icons.person, _nameController.text) ,
                   const Divider(),
                   if(_isEditing) _buildProfileTextField(_emailController, "Email", TextInputType.emailAddress)
                 else  _buildReadOnlyProfileField("Email", Icons.email, _emailController.text),
                   const Divider(),
                   if (_isEditing) _buildProfileTextField(_phoneController, "Phone", TextInputType.phone)
                   else _buildReadOnlyProfileField("Phone", Icons.phone, _phoneController.text),
                    const Divider(),
                   if (_isEditing) _buildProfileTextField(_locationController, "Location", TextInputType.text)
                   else  _buildReadOnlyProfileField("Location", Icons.location_on, _locationController.text),
                 ],
              )),
              _buildProfileInfoSection("Bio", _isEditing ? _buildProfileTextField(_bioController, "Bio", TextInputType.multiline)
             : Text(_bioController.text, style:  const TextStyle(fontSize: 16, height: 1.4),
                textAlign: TextAlign.left,)),
              const SizedBox(height: 10),
               if (_isEditing)
                 Center(
                   child: ElevatedButton(
                      onPressed: _saveProfileChanges,
                      child: const Text('Save Changes'),
                    ),
                 ),
                Center(
                  child: ElevatedButton(
                    onPressed: _logout,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text('Logout', style: TextStyle(color: Colors.white)),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}