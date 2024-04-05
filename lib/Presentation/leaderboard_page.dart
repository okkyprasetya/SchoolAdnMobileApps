import 'package:flutter/material.dart';
import 'package:schooladn_rev/Data/Repository/user_repository.dart';
import 'package:schooladn_rev/Domain/Entities/rankDataModel.dart';

class LeaderboardPage extends StatelessWidget {
  final String token;

  const LeaderboardPage({Key? key, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard', style: TextStyle(color: Colors.white)), // Set title color to white
        backgroundColor: Colors.black, // Set app bar background to black
        iconTheme: IconThemeData(color: Colors.white), // Set icon color to white
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_image.jpg'), // Specify your image path here
            fit: BoxFit.cover,
          ),
        ),
        child: Card( // Wrap the ListView.builder with a Card widget
          margin: EdgeInsets.all(16.0),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: FutureBuilder<List<RankDataModel>>(
            future: UserRepository().getRank(token),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // While data is loading
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // If an error occurred
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                // If data is successfully loaded
                final leaderboardData = snapshot.data!;
                return ListView.builder(
                  itemCount: leaderboardData.length,
                  itemBuilder: (context, index) {
                    final rankData = leaderboardData[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: ListTile(
                        title: Text(rankData.name),
                        subtitle: Text('Rank: ${rankData.rank}'),
                        trailing: Text('Score: ${rankData.totalScore}'),
                      ),
                    );
                  },
                );
              } else {
                // If no data is available
                return Center(child: Text('No data available'));
              }
            },
          ),
        ),
      ),
    );
  }
}
