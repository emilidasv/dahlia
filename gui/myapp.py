import tkinter as tk
import tkmacosx as tkmac
import sqlite3


my_height = 500
my_width = 600

def get_flower_by_name(name_of_flower):
    try:
        print(name_of_flower)
        conn = sqlite3.connect('dahlia2.db')
# create cursor
        curs = conn.cursor()
        curs.execute("select * from flowers where name=" , name_of_flower)
        print(curs)

# close conentcion
        conn.close()
    except:
        print("error")


root = tk.Tk()
root.title("Our Dahlias")

canvas = tk.Canvas(root, height=my_height, width=my_width )
canvas.pack()

background_image = tk.PhotoImage(file='flowers.png')
background_label = tk.Label(root, image=background_image)
background_label.place(relwidth=1, relheight=1)

frame = tk.Frame(root, bg='white', bd=5)
frame.place(relx=0.5, rely=0.1, relwidth=0.75, relheight=0.1, anchor='n')

entry = tk.Entry(frame, font=40)
entry.place(relwidth=0.70, relheight=1)

button1 = tkmac.Button(frame, text="Search by Name", fg='white', bg="#006438" ,font=40, command=lambda: get_flower_by_name(entry.get()))
button1.place(relx=0.70, relheight=1, relwidth=0.3)



frame2 = tk.Frame(root, bg='white', bd=5)
frame2.place(relx=0.5, rely=0.25, relwidth=0.75, relheight=0.1, anchor='n')

Checkvar1 = tk.IntVar()
Checkvar2 = tk.IntVar()
Checkvar3 = tk.IntVar()
checkbutton1 = tk.Checkbutton(frame2, fg = "#006438", bg='white', text="White", variable = Checkvar1)
checkbutton1.place(relheight=0.5, relwidth=0.2)
checkbutton2 = tk.Checkbutton ( frame2, fg= "white",bg="#c73381", text="Pink", variable = Checkvar2)
checkbutton2.place(relx=0.25, relheight=0.5, relwidth=0.2)
checkbutton3 = tk.Checkbutton ( frame2, fg= "white",bg="#a83032", text="Red", variable = Checkvar3)
checkbutton3.place(relx=0.5, relheight=0.5, relwidth=0.2)

Checkvar4 = tk.IntVar()
Checkvar5 = tk.IntVar()
Checkvar6 = tk.IntVar()
checkbutton4 = tk.Checkbutton(frame2, fg= "white", bg='#e64300', text="Orange", variable = Checkvar4)
checkbutton4.place(rely = 0.6, relheight=0.5, relwidth=0.2)
checkbutton5 = tk.Checkbutton ( frame2, fg= "white",bg="#f7d820", text="Yellow", variable = Checkvar5)
checkbutton5.place(relx=0.25, rely = 0.6, relheight=0.5, relwidth=0.2)
checkbutton6 = tk.Checkbutton ( frame2, fg= "white",bg="#603b88", text="Purple", variable = Checkvar6)
checkbutton6.place(relx=0.5, rely = 0.6, relheight=0.5, relwidth=0.2)
button2 = tkmac.Button(frame2, text="Search by Color", fg='white', bg="#006438" ,font=40, command=lambda: get_weather(entry.get()))
button2.place(relx=0.70, relheight=1, relwidth=0.3)

frame3 = tk.Frame(root, bg='white', bd=5)
frame3.place(relx=0.5, rely=0.4, relwidth=0.75, relheight=0.125, anchor='n')
Lb1 = tk.Listbox(frame3)
Lb1.insert(1, "Large")
Lb1.insert(2, "Middle")
Lb1.insert(3, "Small")

Lb1.place(relwidth=0.70, relheight=1)

button3 = tkmac.Button(frame3, text="Search by Size", fg='white', bg="#006438" ,font=40, command=lambda: get_weather(entry.get()))
button3.place(relx=0.70, relheight=1, relwidth=0.3)


frame4 = tk.Frame(root, bg='white', bd=5)
frame4.place(relx=0.5, rely=0.575, relwidth=0.75, relheight=0.3, anchor='n')

Lb2 = tk.Listbox(frame4)
Lb2.insert(1, "Pompon")
Lb2.insert(2, "Peony")
Lb2.insert(3, "Cactus")
Lb2.insert(4, "Anemome")
Lb2.insert(5, "Cactus")
Lb2.insert(6, "Semi-Cactus")
Lb2.insert(7, "Dinnerplate")
Lb2.insert(8, "Waterlily")


Lb2.place(relwidth=0.70, relheight=1)
button4 = tkmac.Button(frame4, text="Search by Type", fg='white', bg="#006438" ,font=40, command=lambda: get_flower_by_name(entry.get()))
button4.place(relx=0.70, relheight=1, relwidth=0.3)

root.mainloop()
