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

  def create_bookmark
    @paper = Paper.find(params[:id])
    @session_user.bookmarks.find_or_create_by_paper_id(@paper.id)
    redirect_to(@paper, :notice => 'Paper bookmarked')
  end

  def destroy_bookmark
    @paper = Paper.find(params[:id])
    @session_user.bookmarks.where(:paper_id => @paper.id).destroy_all
    redirect_to(@paper, :notice => 'Bookmark removed')
  end

  def save
    ActiveRecord::Base.transaction do
      do_save
    end
  end

  def do_save
    @author_list = params[:author_list]

    authors = authors_from_list(@author_list)
    contributions = authors.each_with_index.map do |a, i|
      @paper.contributions.build(:author => a, :position => i)
    end

    p = params[:paper]
    @paper.title = p[:title].try(:strip)
    @paper.abstract = fix_abstract(p[:abstract]) if p[:abstract]
    @paper.year = p[:year]
    @paper.contributions = contributions

    if p[:file].present?
      file = p[:file]
      unless file.original_filename.downcase.ends_with? '.pdf'
        @paper.errors.add(:base, 'filename does not end in .pdf')
        return false
      end
      data = file.read
      unless data.starts_with? '%PDF-'
        @paper.errors.add(:base, 'file does not appear to be a PDF')
        return false
      end
      @paper.sources << @paper.sources.build_from_data('pdf', data)
    end

    @paper.save
  end

private
  def fix_abstract(s)
    s.gsub('- ', '').tr("\t", ' ').squeeze(' ').strip
  end

  def authors_from_list(s)
    s.to_s.
      delete("\u2217\u002b\u2020\u2021").
      split(/[ ,]and |[,\n]/).
      map(&:strip).map(&:presence).compact.
      map {|a| Author.find_or_create_by_name(a) }
  end
end
