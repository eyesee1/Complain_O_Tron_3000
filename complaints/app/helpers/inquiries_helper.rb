module InquiriesHelper
  def natures_of_requests()
    return [
        ['I have a burning desire to <strong>join</strong> a Complaints Choir', 'Join'],
        ['I have a burning desire to <strong>start</strong> a Complaints Choir', 'Start'],
        ['<strong>Comment</strong> about Complain-O-Tron 3000™', 'Comment'],
        ['<strong>Question</strong> about Complain-O-Tron 3000™', 'Question'],
        ["<strong>Suggestion</strong> to improve Complain-O-Tron 3000™'s Programming", 'Suggestion'],
        ['<strong>Problem</strong> using Complain-O-Tron 3000™', 'Problem'],
        ['<strong>Spam</strong>: I would like to send you some now, here it comes!', 'Spam'],
        ['<strong>Other</strong>: The Complain-O-Tron 3000™ has failed to anticipate my needs, just like everyone else, and herein I shall explain the way(s) in which the Complain-O-Tron 3000™ has contributed to an endless cycle of disappointment with giant robots.', 'Other'],
      ]
  end
  
  def nature_by_short(short)
    for r in natures_of_requests
      if r[1] == short
        return r[0]
      end
    end
    return ""
  end
  
  def inquiry_email_subject(inquiry)
    return 'Re: ' + strip_tags(nature_by_short(inquiry.nature))
  end
  
end
