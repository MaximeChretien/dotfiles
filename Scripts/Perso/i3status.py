#! /usr/bin/python3

from threading import Thread
from sys import stdout
import datetime
import time
import locale
import psutil
import subprocess
import re

locale.setlocale(locale.LC_TIME, "de_DE.UTF-8")

def pangofy(s, **kwargs):
    """
    applies kwargs to s, pango style, returning a span string
    """
    a = (
        "<span "
        + " ".join(["{}='{}'".format(k, v) for k, v in kwargs.items() if v is not None])
        + '>'
    )
    b = "</span>"
    return a + s + b


def colorify(s, color):
    return pangofy(s, color=color)

color_base = '#222222'
color_capslock = '#004466'
color = color_base
open_part = colorify('{', '#808080')
close_part = colorify('}', '#808080')
open_elem = colorify('[', '#737373')
close_elem = colorify(']', '#737373')
elem_color = '#A2A2A2'

battery_info=''
cpu_info=''
temp_info=''
ram_swap_info=''
disks_info=''
time_date_info=''


class Display (Thread):
    def __init__(self):
        super().__init__()

    def run(self):
        stdout.write('{"version":1}[')
        stdout.flush()

        i=0
        while True:
            output='[{"name":"Status bar","full_text":"'
            #output+=open_part + cpu_info + close_part
            #output+=open_part + temp_info + close_part
            #output+=open_part + ram_swap_info + close_part
            #output+=open_part + disks_info + close_part
            output+=open_part + time_date_info + close_part
            #output+=open_part + battery_info + close_part
            output+='","markup": "pango",'
            output+='"background": "'+ color + '"}],'

            stdout.write(output)
            stdout.flush()

            time.sleep(1.5)


class Getter (Thread):
    def __init__(self):
        super().__init__()
        self.update = 2.5

    def run(self):
        global battery_info, cpu_info, temp_info, ram_swap_info, disks_info, time_date_info, color

        i = 20
        while True:
            #if i >= 20:
                #battery_info = self.get_battery_info()
                #disks_info = self.get_disks_info()

                #i=0

            #cpu_info = self.get_cpu_info()
            #temp_info = self.get_temp_info()
            #ram_swap_info = self.get_ram_swap_info()
            time_date_info = self.get_time_date()

            if self.get_capslock() == '1':
                color = color_capslock
            else:
                color = color_base

            i += self.update
            time.sleep(self.update)

    def get_battery_info(self):
        percent, left, plugged = psutil.sensors_battery()

        m, s = divmod(left, 60)
        h, m = divmod(m, 60)

        s = format(s, '02d')
        m = format(m, '02d')
        h = format(h, '02d')

        if plugged:
            info = colorify('🗲', '#FFDF34')
        elif left != -1:
            info = h + ':' + m + ':' + s
        else:
            info = 'AC'

        output = '{:3.1f}'.format(percent) + colorify('%(', elem_color) + info  + colorify(')', elem_color)

        return output

    def get_cpu_info(self):
        global open_elem, close_elem

        fcpu0, fcpu1, fcpu2, fcpu3 = psutil.cpu_freq(percpu=True)
        fcpu0 = format(fcpu0.current/1000, '04.2f')
        fcpu1 = format(fcpu1.current/1000, '04.2f')
        fcpu2 = format(fcpu2.current/1000, '04.2f')
        fcpu3 = format(fcpu3.current/1000, '04.2f')

        lcpu0, lcpu1, lcpu2, lcpu3 = psutil.cpu_percent(percpu=True)
        lcpu0 = format(lcpu0, '04.1f')
        lcpu1 = format(lcpu1, '04.1f')
        lcpu2 = format(lcpu2, '04.1f')
        lcpu3 = format(lcpu3, '04.1f')

        output = open_elem + lcpu0 + colorify('% ', elem_color) + fcpu0 + colorify('GHz', elem_color) + close_elem
        output += open_elem + lcpu1 + colorify('% ', elem_color) + fcpu1 + colorify('GHz', elem_color) + close_elem
        output += open_elem + lcpu2 + colorify('% ', elem_color) + fcpu2 + colorify('GHz', elem_color) + close_elem
        output += open_elem + lcpu3 + colorify('% ', elem_color) + fcpu3 + colorify('GHz', elem_color) + close_elem

        return output

    def get_temp_info(self):
        temp = psutil.sensors_temperatures()['coretemp'][0].current

        temp = format(temp, '03.1f')

        output = temp + colorify('°C', elem_color)

        return output

    def get_ram_swap_info(self):
        ram = psutil.virtual_memory()
        swap = psutil.swap_memory()

        ramU = format(ram.used/1024**2, '03.0f')
        ramT = format(ram.total/1024**2, '03.0f')
        swapU = format(swap.used/1024**2, '03.0f')
        swapT = format(swap.total/1024**2, '03.0f')

        output = ramU + colorify('MiB/', elem_color) + ramT + colorify('MiB ', elem_color)
        output += swapU + colorify('MiB/', elem_color) + swapT + colorify('MiB', elem_color)

        return output

    def get_disks_info(self):
        root = psutil.disk_usage('/').free
        data = psutil.disk_usage('/mnt/dataSSD').free
        emmc = psutil.disk_usage('/mnt/dataEMMC').free

        root = format(root/1024**3, '.1f')
        data = format(data/1024**3, '.1f')
        emmc = format(emmc/1024**3, '.1f')

        output = colorify('root:', elem_color) + root + colorify('GiB data:', elem_color) + data + colorify('GiB emmc:', elem_color) + emmc + colorify('GiB', elem_color)

        return output

    def get_time_date(self):

        now = datetime.datetime.now()

        output = datetime.date.strftime(now, "%d %B %Y")
        #output += self.generate_binary_clock(now.hour, now.minute)
        output += self.generate_clock(now.hour, now.minute)

        return output

    def generate_binary_clock(self, hours, minutes):
        h = format(hours, '06b')
        m = format(minutes, '06b')

        output = colorify('❙', elem_color)

        for i in range(6):
            if int(h[i]) and int(m[i]):
                output += '█'
            elif int(h[i]) and not int(m[i]):
                output += '▀'
            elif int(m[i]) and not int(h[i]):
                output += '▄'
            else:
                output += ' '

        output += colorify('❙', elem_color)
        return output

    def generate_clock(self, hours, minutes):
        return " {:0=2d}:{:0=2d}".format(hours, minutes)

    def get_capslock(self):
        out = subprocess.check_output(['xset', 'q'])
        m = re.search(r"LED mask:  \d{7}(\d)", out.decode())

        return m.group(1)


# Main

disp = Display()
getter = Getter()

getter.start()
disp.start()
