#!/usr/bin/env python
# Code based on Doug Hellmann's tutorial on imaplib.
# Author : Ricardo Perez Olivares XE1GYP

import poplib
# TODO: To create an option to connect via IMAP services.
import email
import imaplib

# TODO: Send POP server as an argument to connect by any other service
# and leave Gmail as default
 
M = poplib.POP3_SSL('pop.gmail.com',995)
print"Connecting to pop.gmail.com"

# Reading user and password for Gmail account
MailUser = raw_input('Enter the username@gmail.com:')
print MailUser
M.user(MailUser)
MailPassword = raw_input('Enter the password:')
print MailPassword
M.pass_(MailPassword)
print "User is authenticated"

# Reading messages from inbox
numMessages = len(M.list()[1])
for i in range(numMessages):
	for j in M.retr(i+1)[1]:
		print j
M.quit()
