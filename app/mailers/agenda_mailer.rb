class AgendaMailer < ApplicationMailer
  default from: 'dip@example.com'

  def agenda_info_mail(agenda)
    @agenda = agenda
    @team = agenda.team
    email = @team.members.pluck(:email)
    mail(to: email, subject: "お知らせ")
  end
end
