import 'package:path/path.dart';
import 'package:pro_sche/util/date_extention.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static Future<Database> get database async {
    var date = DateExtention.dateOnlyNow().toUtc().toIso8601String();
    final Future<Database> _database = openDatabase(
      join(await getDatabasesPath(), 'app_database.db'),
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE task(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT,note TEXT,status INTEGER,progress INTEGER, deadline TEXT,"
                "priority INTEGER,event_id INTEGER,section_id INTEGER,created_at TEXT,updated_at TEXT)");
        await db.execute(
            "CREATE TABLE event(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT,note TEXT,isAll INTEGER,target_date TEXT,"
                "start_time TEXT,end_time TEXT, created_at TEXT, updated_at TEXT)");
        await db.execute(
            "CREATE TABLE section(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,description TEXT, created_at TEXT, updated_at TEXT)");
        await db.execute(
            "CREATE TABLE action(id INTEGER PRIMARY KEY AUTOINCREMENT, context TEXT, created_at TEXT)");
        await db.execute(
            "CREATE TABLE task_tracker(id INTEGER PRIMARY KEY AUTOINCREMENT, task_id INTEGER,note TEXT,created_at TEXT, updated_at TEXT)");
        await db.execute(
            "insert into task (id,title,note,status,progress,deadline,priority,event_id,section_id,created_at,updated_at)values(1, 'todo', '内容',1,0,'$date',1,1,null,'$date','$date')");
        /*
        await db.execute(
            "CREATE TABLE category(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,text TEXT,createdAt TEXT)");
        await db.execute(
            "CREATE TABLE variety(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,text TEXT,unit TEXT,categoryId INTEGER,createdAt TEXT)");
        await db.execute(
            "CREATE TABLE recode(id INTEGER PRIMARY KEY AUTOINCREMENT, value REAL,text TEXT,varietyId INTEGER,targetDate TEXT,imagePass TEXT,createdAt TEXT)");
        await db.execute(
            "insert into category (name,text,createdAt)values('身体', '身体に関しての項目', '$date')");
        await db.execute(
            "insert into category (name,text,createdAt)values('食事', '食事に関しての項目', '$date')");
        await db.execute(
            "insert into category (name,text,createdAt)values('運動', '運動に関しての項目', '$date')");

         */
      },
      /*
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        /* version: 2, */
        await db
            .execute("ALTER TABLE todo ADD COLUMN hour INTEGER DEFAULT (0);");
        await db.execute(
            "ALTER TABLE todo ADD COLUMN minutes INTEGER DEFAULT (0);");
        await db.execute(
            "ALTER TABLE todo ADD COLUMN isAllday INTEGER DEFAULT (0);");

        await db.execute(
            "ALTER TABLE todo ADD COLUMN imagePass TEXT DEFAULT ('');");
      },*/
      version: 1,
    );
    return _database;
  }
}