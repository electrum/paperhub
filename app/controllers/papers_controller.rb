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
    @author_list = @paper.authors.map(&:name).join(', ')
  end

  def create
    @paper = Paper.new
    if save
      redirect_to(@paper, :notice => 'Paper created')
    else
      render :action => :new
    end
  end

  def update
    @paper = Paper.find(params[:id])
    if save
      redirect_to(@paper, :notice => 'Paper updated')
    else
      render :action => :edit
    end
  end

  def save
    @author_list = params[:author_list]

    authors = authors_from_list(@author_list)
    contributions = authors.each_with_index.map do |a, i|
      @paper.contributions.build(:author => a, :position => i)
    end

    p = params[:paper]
    @paper.title = p[:title]
    @paper.abstract = fix_abstract(p[:abstract]) if p[:abstract]
    @paper.year = p[:year]
    @paper.contributions = contributions

    @paper.save
  end

private
  def fix_abstract(s)
    s.gsub('- ', '').gsub(/[ \t]{2,}/, ' ')
  end

  def authors_from_list(s)
    s.to_s.split(/[,\n]/).
      map {|i| i.gsub(/\A\s*and /, '') }.
      map(&:strip).map(&:presence).compact.
      map {|a| Author.find_or_create_by_name(a) }
  end
end
