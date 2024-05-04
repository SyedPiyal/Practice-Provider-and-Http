import 'package:flutter/material.dart';
import 'package:practice_provider/provider/comments_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

// The state class for the HomePage widget.
class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    // This callback is called after the widget is fully built.
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      // Call the getAllTodos method of the TodoProvider to fetch Todo items.
      Provider.of<CommentsProvider>(context, listen: false).getAllComments();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Build method for the HomePage widget.
    return Scaffold(
      // Set app bar title.
      appBar: AppBar(
        title: const Text('Provider API'),
      ),
      // Consumer widget to listen for changes in TodoProvider.
      body: Consumer<CommentsProvider>(
        builder: (context, value, child) {
          // Check if data is currently being loaded.
          if (value.isLoading) {
            // If loading, display a CircularProgressIndicator.
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // If not loading, retrieve the list of Todo items.
          final comments = value.comments;

          // Build a ListView to display the Todo items.
          return ListView.builder(
            itemCount: comments.length,
            itemBuilder: (context, index) {
              final comment = comments[index];
              // Build a ListTile for each Todo item.
              return ListTile(
                // Display Todo ID in a CircleAvatar.
                leading: CircleAvatar(
                  child: Text(comment.id.toString()),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start ,
                  children: [
                    //===========-> name <-===========//
                    Text(
                      "Name: ${comment.name!}", // Display Todo title.
                    ),

                    //===========-> email <-===========//
                    Text(
                      "Email: ${comment.email!}",
                    ),

                    //===========-> body <-===========//
                    Text(
                      comment.body!, // Display Todo title.
                      style: TextStyle(
                        // Set text color based on completion status.
                        color:
                            comment.body != null ? Colors.grey : Colors.black,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
