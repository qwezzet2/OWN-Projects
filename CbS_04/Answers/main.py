#!/usr/bin/env python3
from scapy.all import *
import os

# Создаем папку если нет
os.makedirs("src", exist_ok=True)

# Сообщение для отправки
message = "Dear Steel Cat! This is no attack, it's my humster Pinkie you should track"

# Создаем пакет
packet = IP(dst="127.0.0.1")/TCP(dport=12345)/message

# Сохраняем пакет ВПЕРВЫЕ (до отправки)
wrpcap("src/sent_message.pcapng", packet)

# Отправляем пакет
send(packet, verbose=0)

print("Сообщение отправлено и сохранено в src/sent_message.pcapng")
