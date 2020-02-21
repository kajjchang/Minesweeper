import de.bezier.guido.*;
private static final int NUM_ROWS = 20,
                         NUM_COLS = 20,
                         NUM_MINES = 20;
private MSButton[][] buttons;
private ArrayList<MSButton> mines;
private boolean started;

void setup () {
    size(400, 400);
    textAlign(CENTER, CENTER);
    
    Interactive.make(this);
    
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for (int r = 0; r < NUM_ROWS; r++) {
        for (int c = 0; c < NUM_ROWS; c++) {
            buttons[r][c] = new MSButton(r, c);
        }
    }

    started = false;
}

public void setMines(int start_r, int start_c) {
    while (mines.size() < NUM_MINES) {
        int r = (int) random(NUM_ROWS);
        int c = (int) random(NUM_COLS);
        MSButton button = buttons[r][c];
        if (!mines.contains(button) && r != start_r && c != start_c) {
            mines.add(button);
        }
    }
}

public void draw() {
    background(0);
    if (isWon()) {
        displayWinningMessage();
    }
}

public boolean isWon() {
    boolean won = true;
    for (MSButton mine : mines) {
        if (!mine.isFlagged()) {
            won = false;
        }
    }
    return won;
}

public void displayLosingMessage() {
    text("You Lost!", width / 2, height / 2);
}

public void displayWinningMessage() {
    text("You Won!", width / 2, height / 2);
}

public boolean isValid(int r, int c) {
    return r >= 0 && c >= 0 && r < NUM_ROWS && c < NUM_COLS;
}

public int countMines(int r, int c) {
    int num_mines = 0;
    for (int i = -1; i <= 1; i++) {
        for (int j = -1; j <= 1; j++) {
            if (isValid(r + i, c + j) && mines.contains(buttons[r][c])) {
                num_mines++;
            }
        }
    }
    return num_mines;
}

public class MSButton {
    private float x, y, width, height;
    private boolean clicked, flagged;
    private String label;
    
    public MSButton(int r, int c) {
        width = width / NUM_COLS;
        height = height / NUM_ROWS;
        x = c * width;
        y = r * height;
        label = "";
        flagged = clicked = false;
        Interactive.add(this);
    }

    public void mousePressed() {
        clicked = true;
        //your code here
    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
        // else if( clicked && mines.contains(this) ) 
        //     fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label, x + width / 2, y + height / 2);
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public void setLabel(int label) {
        this.label = "" + label;
    }

    public boolean isFlagged() {
        return flagged;
    }
}
