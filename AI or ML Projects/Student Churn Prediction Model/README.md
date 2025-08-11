# Student Churn Prediction Model

This project predicts student churn (likelihood of dropping out) based on invoices, marks, and attendance data.  
It uses a trained machine learning model stored in `churn_model.pkl`.

---

## 📂 Folder Structure
Student Churn Prediction Model/
│
├── Main_Notebook.ipynb     # The jupyter notebook on which the bulk of the project was made. The main.py program borrows the majority of the code from this file. │                           # In essence, it does the same thing as the main.py file. But it has a sequential order of each step taken during the project.
├── data/                   # where the input CSV files are stored
│   ├── invoices.csv
│   ├── marks.csv
│   ├── attendance1.csv
│   ├── attendance2.csv
│   ├── attendance3.csv
│   └── attendance4.csv
│   └── Ultimate1.csv       # The pre-transformed dataset upon which the model was trained.
│
├── churn_model.pkl         # Trained ML model
│
├── output/                 # Predictions will be saved in a CSV file in this folder
│   └── predictions.csv     # CSV File Containing Predictions
│   └── tree_visualization.png     # Image file containing a tree visualisation for the prediciton pathway of the model.
│   └── feature_importance.png     # Image file containing the visualisation for the importance of each feature in the model.
├── main.py                 # Driver code
│
├── dependencies.txt        # Required Python packages
└── README.md               # Project documentation


## ⚙️ Setup Instructions
### 1. Clone or download the repository
`git clone https://github.com/sami-shah-210504/My-Projects.git
 cd "My-Projects/AI or ML Projects/Student Churn Prediction Model`

### 2. Install dependencies
`pip install -r dependencies.txt`
### 3. Prepare input files
Place your CSV data files into the data/ folder.
Ensure the filenames match those in main.py or update the script accordingly.

## ▶️ Running the Project
### 1. To run predictions
`python main.py`
### 2. Prepare input files

The output will be saved in output/predictions.csv.

The visuals for the model will also be saved in output/feature_importance.png and output/tree_visualization.png.
