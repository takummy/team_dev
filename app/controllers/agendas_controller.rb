class AgendasController < ApplicationController
  # before_action :set_agenda, only: %i[show edit update destroy]
  before_action :require_owner_or_author, only: :destroy

  def index
    @agendas = Agenda.all
  end

  def new
    @team = Team.friendly.find(params[:team_id])
    @agenda = Agenda.new
  end

  def create
    @agenda = current_user.agendas.build(title: params[:title])
    @agenda.team = Team.friendly.find(params[:team_id])
    current_user.keep_team_id = @agenda.team.id
    if current_user.save && @agenda.save
      redirect_to dashboard_url, notice: 'アジェンダ作成に成功しました！'
    else
      render :new
    end
  end

  def destroy
    agenda = Agenda.find(params[:id])
    agendas = agenda.all.includes(:team, :users)
    agenda.destroy
    redirect_to dashboard_url, notice: "削除しました"
  end

  private

  def set_agenda
    @agenda = Agenda.find(params[:id])
  end

  def agenda_params
    params.fetch(:agenda, {}).permit %i[title description]
  end

  def require_owner_or_author
    agenda = Agenda.find(params[:id])
    unless current_user.id == agenda.user.id || current_user.id == agenda.team.owner.id
      redirect_to agenda.team, notice: "権限がありません"
    end
  end
end
