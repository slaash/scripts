from argparse import ArgumentParser
import sys
import smtplib
from email.mime.text import MIMEText

def _sendmail(subject,src,dest,content):
    message = MIMEText(content)

    message['Subject'], message['From'], message['To'] = subject, src, dest

    try:
        sm = smtplib.SMTP('localhost')
        sm.sendmail(args.src, args.dest, message.as_string())
        sm.quit()
    except Exception, e:
        print >> sys.stderr, e.message
        sys.exit(1)

    sys.exit(0)


if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument('--dest', dest='dest', action='store', default=None,
                        help='destination e-mail')
    parser.add_argument('--src', dest='src', action='store', default=None,
                        help='source email')
    parser.add_argument('--subject', dest='subject', action='store', default=None,
                        help='e-mail subject')
    parser.add_argument('--content', dest='content', action='store', default=None,
                        help='content of e-mail. either a string or @filename')

    args = parser.parse_args()

    if not args.dest or not args.src or not args.subject or not args.content:
        print >> sys.stderr, "Destination, source, subject and content must be specified. See -h"
        sys.exit(1)

    try:
        content = open(args.content[1:], 'r').read() if args.content[0] == '@' else args.content
    except Exception, e:
        print >> sys.stderr, e.message
        sys.exit(1)

    _sendmail(args.subject, args.src, args.dest, content)
