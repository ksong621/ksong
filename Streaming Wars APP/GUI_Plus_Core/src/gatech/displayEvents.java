package gatech;

import javax.swing.*;
import javax.swing.table.AbstractTableModel;

public class displayEvents {
    private JTable eventsTable;
    private JPanel displayEventPanel;
    private MyTableModel tableModel = new MyTableModel();

    public JTable getEventsTable() {
        return eventsTable;
    }
    public void settableData(Object[][] objectArr){
        tableModel.setData(objectArr);
        tableModel.fireTableDataChanged();
    }
    public JPanel getDisplayEventPanel() {
        eventsTable.setModel(tableModel);
        return displayEventPanel;
    }

    class MyTableModel extends AbstractTableModel {
        private String[] columnNames = {"First Name",
                "Last Name",
                "Sport",
                "# of Years",
                "Vegetarian",
                "d"
        };

        private Object[][] data = {
                {"Kathy", "Smith",
                        "Snowboarding", "test1", "test2", "d"},

        };

        public void setColumnNames(String[] columnNames) {
            this.columnNames = columnNames;
        }

        public void setData(Object[][] data) {
            this.data = data;
        }

        public int getColumnCount() {
            return columnNames.length;
        }

        public int getRowCount() {
            return data.length;
        }

        public String getColumnName(int col) {
            return columnNames[col];
        }

        public Object getValueAt(int row, int col) {
            return data[row][col];
        }

        /*
         * JTable uses this method to determine the default renderer/
         * editor for each cell.  If we didn't implement this method,
         * then the last column would contain text ("true"/"false"),
         * rather than a check box.
         */
        public Class getColumnClass(int c) {
            return getValueAt(0, c).getClass();
        }

        /*
         * Don't need to implement this method unless your table's
         * editable.
         */
        public boolean isCellEditable(int row, int col) {
            //Note that the data/cell address is constant,
            //no matter where the cell appears onscreen.
            if (col < 2) {
                return false;
            } else {
                return true;
            }
        }

        /*
         * Don't need to implement this method unless your table's
         * data can change.
         */
        public void setValueAt(Object value, int row, int col) {
            data[row][col] = value;
            fireTableCellUpdated(row, col);
        }

    }
}
