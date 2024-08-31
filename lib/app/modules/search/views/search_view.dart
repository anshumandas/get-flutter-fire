import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/Search_Controller.dart';

class SearchView extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  final MySearchController _searchCtrl = Get.put(MySearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Enter FIDE ID here',
                hintStyle: TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.black,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.white, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.white, width: 1.0),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search, color: Colors.white),
                  onPressed: () {
                    _searchCtrl.performSearch(_searchController.text.trim());
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Obx(() {
              if (_searchCtrl.isLoading.value) {
                return Center(child: CircularProgressIndicator(color: Colors.white));
              } else if (_searchCtrl.playerDetails.isEmpty && _searchCtrl.history.isEmpty) {
                // Display an image when no search has been performed or when results are empty
                return Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/search.gif', // Replace with your image path
                          width: 150, // Adjust the width as needed
                          height: 150, // Adjust the height as needed
                        ),
                        SizedBox(height: 20),
                        Text(
                          'No search results yet.',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                // Display search results
                return Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Display player details
                        if (_searchCtrl.playerDetails.isNotEmpty) ...[
                          _buildSectionTitle('Player Details'),
                          SizedBox(height: 10),
                          _buildDetailCard(_searchCtrl.playerDetails.value), // Use .value here
                        ],
                        SizedBox(height: 20),
                        // Display history in a scrollable area
                        if (_searchCtrl.history.isNotEmpty) ...[
                          _buildSectionTitle('History'),
                          SizedBox(height: 10),
                          Container(
                            height: 200, // Adjust height as needed
                            child: ListView.builder(
                              itemCount: _searchCtrl.history.length,
                              itemBuilder: (context, index) {
                                final item = _searchCtrl.history[index];
                                return _buildHistoryCard(item);
                              },
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }
            }),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        decoration: TextDecoration.underline,
      ),
    );
  }

  Widget _buildDetailCard(Map<String, dynamic> details) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.white, width: 1.0),
      ),
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow('Name', details['name']),
          _buildDetailRow('FIDE ID', details['fide_id']),
          _buildDetailRow('Title', details['fide_title']),
          _buildDetailRow('Federation', details['federation']),
          _buildDetailRow('Birth Year', details['birth_year']),
          _buildDetailRow('Sex', details['sex']),
          _buildDetailRow('World Rank (All)', details['world_rank_all']),
          _buildDetailRow('World Rank (Active)', details['world_rank_active']),
          _buildDetailRow('Continental Rank (All)', details['continental_rank_all']),
          _buildDetailRow('Continental Rank (Active)', details['continental_rank_active']),
          _buildDetailRow('National Rank (All)', details['national_rank_all']),
          _buildDetailRow('National Rank (Active)', details['national_rank_active']),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(Map<String, dynamic> history) {
    return Card(
      color: Colors.black,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        title: Text(
          '${history['period']}',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHistoryRow('Classical Rating', history['classical_rating']),
            _buildHistoryRow('Classical Games', history['classical_games']),
            _buildHistoryRow('Rapid Rating', history['rapid_rating']),
            _buildHistoryRow('Rapid Games', history['rapid_games']),
            _buildHistoryRow('Blitz Rating', history['blitz_rating']),
            _buildHistoryRow('Blitz Games', history['blitz_games']),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              '$value',
              style: TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(color: Colors.white54),
          ),
          Expanded(
            child: Text(
              '$value',
              style: TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}
