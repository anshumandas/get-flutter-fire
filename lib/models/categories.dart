class Team {
  final String name;
  final String captain;
  final int titles;

  Team({required this.name, required this.captain, required this.titles});

}

//List of names
final List<Team> teams = [
  Team(name: "Mumbai Indians", captain: "Rohit Sharma", titles: 5),
  Team(name: "Chennai Super Kings", captain: "MS Dhoni", titles: 5),
  Team(name: "Kolkata Knight Riders", captain: "Shreyas Iyer", titles: 3),
  Team(name: "Sunrises Hyderabad", captain: "Pat Cummins", titles: 2),
  Team(name: "Rajasthan Royals", captain: "Sanju Samson", titles: 1),
  Team(name: "Gujarat Titans", captain: "Shubman Gill", titles: 1),
  Team(name: "Lucknow Super Giants", captain: "KL Rahul", titles: 0),
  Team(name: "Punjab Kings", captain: "Shikhar Dhawan", titles: 0),
  Team(name: "Delhi Capitals", captain: "Rishabh Pant", titles: 0),
  Team(name: "Royal Challengers Bengaluru", captain: "Virat Kohli", titles: 0),
];