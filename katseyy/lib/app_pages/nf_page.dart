import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class NewsFeedPage extends StatefulWidget {
  const NewsFeedPage({super.key});

  @override
  _NewsFeedPageState createState() => _NewsFeedPageState();
}

class _NewsFeedPageState extends State<NewsFeedPage> {
  List<Post> _posts = [];

  @override
  void initState() {
    super.initState();
    fetchPosts(); // Fetch posts when the page is initialized
  }

  // Function to fetch posts from the server
  Future<void> fetchPosts() async {
    final response = await http.get(Uri.parse('http://192.168.18.27/KATSEYY/get_posts.php'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        _posts = data.map((json) => Post.fromJson(json)).toList(); // Parse posts from JSON
      });
    } else {
      print('Failed to fetch posts: ${response.statusCode}');
    }
  }

  // Function to add a new post
  Future<void> _addPost(String postText, File? image) async {
    if (postText.isNotEmpty || image != null) {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.18.27/KATSEYY/save_post.php'),
      );

      if (image != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'image',
          image.path,
        ));
      }

      request.fields['text'] = postText;

      try {
        final response = await request.send();
        final responseBody = await http.Response.fromStream(response);

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonResponse = jsonDecode(responseBody.body);

          if (jsonResponse['success'] == true) {
            // Successfully added post
            fetchPosts(); // Refresh the posts list after adding a new post
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Post uploaded successfully!'),
                backgroundColor: Colors.green,
              ),
            );
          } else {
            // Server error message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to save post on the server.'),
                backgroundColor: Colors.red,
              ),
            );
          }
        } else {
          // HTTP error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to upload post. Status: ${response.statusCode}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An error occurred. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      // No content provided
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide text or an image for the post.'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  // Function to show the post dialog
  void _showNewPostDialog() {
    String postText = '';
    File? selectedImage;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Create New Post'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      onChanged: (value) {
                        postText = value;
                      },
                      decoration: InputDecoration(
                        hintText: "Write something...",
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Show selected image if it exists
                    if (selectedImage != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.file(
                          selectedImage!,
                          height: 80,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          setState(() {
                            selectedImage = File(image.path); // Update selectedImage
                          });
                        }
                      },
                      child: const Text('Upload Image'),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    _addPost(postText, selectedImage);
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text('Post'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF2E9), // Light beige background
     
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Displaying posts
              ..._posts.map((post) => PostCard(
                post: post,
                onLike: () {
                  setState(() {
                    post.isLiked = !post.isLiked;
                    post.likeCount += post.isLiked ? 1 : -1;
                  });
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class Post {
  final String? image; // Changed to String to hold the image URL
  final String text;
  bool isLiked = false;
  int likeCount = 0;
  List<String> comments = []; // List to store comments

  Post({this.image, required this.text});

  // Factory method to create Post from JSON
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      image: json['image'] ?? '', // Adjust based on your server's response
      text: json['text'] ?? '',
    );
  }
}

class PostCard extends StatefulWidget {
  final Post post;
  final VoidCallback onLike;

  const PostCard({
    super.key,
    required this.post,
    required this.onLike,
  });

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  String commentText = ''; // Store comment input
  bool showCommentsSection = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Adjust vertical padding only
      child: Container(
        width: 350, // Adjust the width of the PostCard
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255), // Set the desired background color
          borderRadius: BorderRadius.circular(10.0), // Add rounded corners
          border: Border.all(
            color: const Color.fromARGB(255, 158, 137, 241), // Set the border color
            width: 1.0, // Set the border width
          ),
        ),
        child: Card(
          color: const Color.fromARGB(255, 251, 251, 251), // Make the Card's background transparent
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Match the border radius
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image display with defined width and height
              if (widget.post.image != null && widget.post.image!.isNotEmpty)
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ), // Match the top border radius
                  child: Image.network(
                    widget.post.image!,
                    height: 270, // Set the desired height
                    width: 350, // Ensure image takes full width
                    fit: BoxFit.cover, // Ensure image fills the box
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(10.0), // Add padding around text and buttons
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.text,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Like button
                        IconButton(
                          icon: Icon(
                            widget.post.isLiked
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: widget.post.isLiked ? Colors.red : null,
                          ),
                          onPressed: widget.onLike,
                        ),
                        Text(
                          '${widget.post.likeCount} Likes', // Show like count
                          style: const TextStyle(fontSize: 14),
                        ),
                        IconButton(
                          icon: const Icon(Icons.comment),
                          onPressed: () {
                            setState(() {
                              showCommentsSection = !showCommentsSection; // Toggle comment section visibility
                            });
                          },
                        ),
                      ],
                    ),
                    if (showCommentsSection) ...[
                      TextField(
                        onChanged: (value) {
                          commentText = value; // Update comment text
                        },
                        decoration: InputDecoration(
                          hintText: "Write a comment...",
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (commentText.isNotEmpty) {
                              widget.post.comments.add(commentText); // Add comment to post
                              commentText = ''; // Clear input field
                            }
                          });
                        },
                        child: const Text('Comment'),
                      ),
                      ...widget.post.comments.map((comment) => Text(
                        comment,
                        style: const TextStyle(fontSize: 12),
                      )),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
