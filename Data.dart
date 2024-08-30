import 'package:e_book_marketplace/Models/BookModel.dart';

var categoryData = [
  {
    "icon": "Assets/Icons/heart.svg",
    "lebel": "Romance",
  },
  {
    "icon": "Assets/Icons/plane.svg",
    "lebel": "Travel",
  },
  {
    "icon": "Assets/Icons/world.svg",
    "lebel": "Documentary",
  },
  {
    "icon": "Assets/Icons/heart.svg",
    "lebel": "Love Story",
  },
];

var bookData = [
  BookModel(
      id: "1",
      title:
          "Boundaries",
      description:
          "Healthy relationships depend on maintaining effective personal boundaries. But many people don't know where to start. The New York Times bestselling book Boundaries has helped millions understand how to set boundaries in a loving way that builds relationships.",
      aboutAuthor: "Henry Cloud is an American Christian self-help author.",
      audioLen: "20",
      author: "Henry Cloud",
      coverUrl: "Assets/Images/boundraries.jpg",
      rating: "4.2",
      category: "Documentary",
      numberofRating: "10,",
      price: 100,
      pages: 234,
      language: "ENG",
      bookurl:
          "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf"),
  BookModel(
      id: "2",
      title: "Daily Stoice",
      description:
          " The Daily Stoic is an original translation of selections from several stoic philosophers including Epictetus, Marcus Aurelius, Seneca, Musonius Rufus, Zeno and others. It aims to provide lessons about personal growth, life management and practicing mindfulness.",
      aboutAuthor: "Ryan Holiday is an American marketer, author, businessman, notable for marketing Stoic philosophy in the form of books.",
      audioLen: "20",
      author: "Ryan Holiday",
      coverUrl: "Assets/Images/daily stoic.jpg",
      rating: "4.2",
      category: "Documentary",
      price: 100,
      numberofRating: "10,",
      language: "ENG",
      pages: 234,
      bookurl:
          "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf"),
  BookModel(
      id: "3",
      title: "Give and Take",
      description:
          "The theory of 'givers' in 'Give and Take' challenges existing practices in corporate settings by proposing that success is not achieved by pushing others down, but by building others up. This contradicts the traditional belief that self-interest is the key to success.",
      aboutAuthor: "Adam M. Grant is an American popular science author, and professor at the Wharton School of the University of Pennsylvania specializing in organizational psychology.",
      audioLen: "20",
      author: "Adam Grant",
      coverUrl: "Assets/Images/Give and Take.jpg",
      rating: "4.2",
      category: "Documentary",
      numberofRating: "10,",
      price: 100,
      language: "ENG",
      pages: 234,
      bookurl:
          "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf"),
  BookModel(
    id: "4",
    title: "When The Moon Split",
    description:
        "The biography of the Prophet is a very noble and exalted subject by which Muslims learn about the rise of Islam, and how the Prophet Muhammad (S) was chosen by Allah to receive the divine revelation.",
    aboutAuthor: "Safiur Rahman Mubarakpuri was an Indian Islamic scholar, teacher and writer within the Salafi creed. ",
    audioLen: "20",
    author: "Safiur Rahman Mubarakpuri",
    coverUrl: "Assets/Images/When the moon split.jpg",
    rating: "4.2",
    category: "Documentary",
    price: 100,
    pages: 234,
    language: "ENG",
    numberofRating: "10,",
    bookurl:
        "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf",
  )
];