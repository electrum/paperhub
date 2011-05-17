class PapersController < ApplicationController
  def index
    @papers = Paper.all
  end

  def show
    @paper = Paper.find(params[:id])
  end

  def new
    @paper = Paper.new
  end

  def edit
    @paper = Paper.find(params[:id])
  end

  def create
    p = params[:paper]
    @paper = Paper.new
    @paper.title = p[:title]
    @paper.abstract = fix_abstract(p[:abstract]) if p[:abstract]
    @paper.year = p[:year]

    if @paper.save
      redirect_to(@paper, :notice => 'Paper created')
    else
      render :action => :new
    end
  end

  def update
    @paper = Paper.find(params[:id])
    if @paper.update_attributes(params[:paper])
      redirect_to(@paper, :notice => 'Paper updated')
    else
      render :action => :edit
    end
  end

private
  def fix_abstract(s)
    s.gsub('- ', '')
  end
end
